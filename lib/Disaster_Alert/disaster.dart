import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DisasterReportPage extends StatefulWidget {
  @override
  _DisasterReportPageState createState() => _DisasterReportPageState();
}

class _DisasterReportPageState extends State<DisasterReportPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat _timeFormat = DateFormat('HH:mm');

  String selectedDistrict = 'Kottayam';
  String selectedDisasterType = 'Flood'; // Default selected disaster type

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

  TextEditingController severityController = TextEditingController();

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
              Text(
                'Recent Disaster Reports',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
                textAlign: TextAlign.center,
              ),
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
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),


  StreamBuilder<QuerySnapshot>(
  stream: _firestore
      .collection('disaster_reports')
      .doc(selectedDistrict)
      .collection(selectedDisasterType.toLowerCase())
      .snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      // If no data or no reports available, display a message
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_very_satisfied, // Large happy symbol
              size: 80,
              color: Colors.green,
            ),
            SizedBox(height: 10),
            Text(
              'No reports of disasters yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    final reports = snapshot.data!.docs;
    List<Widget> disasterList = [];
    final currentUserEmail = _auth.currentUser?.email;
    for (var report in reports) {
      final reportData = report.data() as Map<String, dynamic>;
      int severity = reportData['severity'] ?? 0;
      Color cardColor = _getColorBySeverity(severity);
      final reportedByEmail = reportData['userEmail'];
      disasterList.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reported by: $reportedByEmail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Reported at: ${_dateFormat.format(DateTime.parse(reportData['timestamp']))} ${_timeFormat.format(DateTime.parse(reportData['timestamp']))}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Severity: $severity',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (reportedByEmail == currentUserEmail)
                    ElevatedButton.icon(
                      onPressed: () {
                        showConfirmationDialog(report.reference.id, reportedByEmail);
                      },
                      icon: Icon(Icons.edit),
                      label: Text('Update/Withdraw'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                ],
              ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show the reporting form in a pop-up
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Report Disaster'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: severityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Severity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      reportDisaster(); // Report disaster
                    },
                    child: Text('Report'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Report Disaster',
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getColorBySeverity(int severity) {
    if (severity >= 0 && severity <= 1) {
      return Colors.green;
    } else if (severity >= 2 && severity <= 3) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  void reportDisaster() async {
    final user = _auth.currentUser;
    if (user != null) {
      final severity = int.tryParse(severityController.text) ?? 0;
      if (severity > 0) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Report'),
            content: Text('Are you sure you want to report this disaster?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  // Proceed with reporting the disaster
                  _submitReport(user, severity);
                },
                child: Text('Confirm'),
              ),
            ],
          ),
        );
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

  void _submitReport(User? user, int severity) async {
    final userReportRef = _firestore
        .collection('user_reports')
        .doc(user!.uid)
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
  }

  void showConfirmationDialog(String reportId, String reportedByEmail) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Update/Withdraw'),
        content: Text('Are you sure you want to update/withdraw this report?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              updateOrWithdrawReport(reportId, reportedByEmail);
              Navigator.pop(context);
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void updateOrWithdrawReport(String reportId, String reportedByEmail) async {
    final user = _auth.currentUser;
    if (user != null && reportedByEmail == user.email) {
      await _firestore
          .collection('disaster_reports')
          .doc(selectedDistrict)
          .collection(selectedDisasterType.toLowerCase())
          .doc(reportId)
          .delete();

      await _firestore
          .collection('user_reports')
          .doc(user.uid)
          .collection('reports')
          .doc(selectedDistrict)
          .delete();
    } else {
      // User is not authenticated or does not have permission to delete this report
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission Denied'),
          content: Text('You do not have permission to delete this report.'),
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
