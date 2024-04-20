import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DisasterReportPage extends StatefulWidget {
  @override
  _DisasterReportPageState createState() => _DisasterReportPageState();
}

class _DisasterReportPageState extends State<DisasterReportPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String selectedDistrict = 'Kottayam';
  String selectedDisasterType = 'Flood'; // Default selected disaster type
  TextEditingController severityController = TextEditingController();

  List<String> districts = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad'
  ];

  List<String> disasterTypes = ['Flood', 'Earthquake', 'Landslide'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Report'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedDistrict,
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value!;
                  });
                },
                items: districts.map((district) {
                  return DropdownMenuItem(
                    child: Text(district),
                    value: district,
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select District',
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedDisasterType,
                onChanged: (value) {
                  setState(() {
                    selectedDisasterType = value!;
                  });
                },
                items: disasterTypes.map((type) {
                  return DropdownMenuItem(
                    child: Text(type),
                    value: type,
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Select Disaster Type',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: severityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Severity',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  reportDisaster();
                },
                child: Text('Report Disaster'),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('disaster_reports')
                    .doc(selectedDistrict)
                    .collection(selectedDisasterType.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final reports = snapshot.data!.docs;
                  List<Widget> disasterList = [];
                  for (var report in reports) {
                    final reportData =
                        report.data() as Map<String, dynamic>;
                    disasterList.add(
                      Card(
                        child: ListTile(
                          title: Text('Reported by: ${reportData['userEmail']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reported at: ${reportData['timestamp']}'),
                              Text('Severity: ${reportData['severity']}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: disasterList,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reportDisaster() async {
    final user = _auth.currentUser;
    if (user != null) {
      final severity = int.tryParse(severityController.text) ?? 0;
      if (severity > 0) {
        final userReportRef = _firestore
            .collection('user_reports')
            .doc(user.uid)
            .collection('reports')
            .doc(selectedDistrict);

        final userReportDoc = await userReportRef.get();
        if (!userReportDoc.exists) {
          await _firestore
              .collection('disaster_reports')
              .doc(selectedDistrict)
              .collection(selectedDisasterType.toLowerCase())
              .doc(user.uid) // Use user's UID as document ID to ensure one report per user per district
              .set({
            'timestamp': DateTime.now().toString(),
            'severity': severity,
            'userEmail': user.email,
          });

          await userReportRef.set({'reported': true});

          severityController.clear();
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Already Reported'),
              content: Text('You have already reported a disaster for this district.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Invalid Severity'),
            content: Text('Please enter a valid severity value.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // User is not authenticated
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Authentication Required'),
          content: Text('You need to sign in to report a disaster.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}