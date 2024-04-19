import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DisasterPage extends StatefulWidget {
  @override
  _DisasterPageState createState() => _DisasterPageState();
}

class _DisasterPageState extends State<DisasterPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String selectedDistrict = "Kottayam";
  String selectedDisasterType = "Flood";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Alert'),
      ),
      body: StreamBuilder(
        stream: _firestore.collectionGroup('disaster_reports').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot alert = snapshot.data!.docs[index];
              // Check if fields exist and parse values
              int floodCount = alert['flood'] != null ? int.tryParse(alert['flood']) ?? 0 : 0;
              int earthquakeCount = alert['earthquake'] != null ? int.tryParse(alert['earthquake']) ?? 0 : 0;
              int landslideCount = alert['landslide'] != null ? int.tryParse(alert['landslide']) ?? 0 : 0;

              // Check if any disaster count is more than 5
              bool showDisaster = false;
              if (floodCount > 5 || earthquakeCount > 5 || landslideCount > 5) {
                showDisaster = true;
              }
              return showDisaster
                  ? _buildDisasterCard(alert)
                  : SizedBox.shrink();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reportDisaster,
        tooltip: 'Report Disaster',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDisasterCard(DocumentSnapshot alert) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Disaster Alert'),
        subtitle: Text('${alert.id}'),
      ),
    );
  }

  void _reportDisaster() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report Disaster'),
          content: Container(
            height: 200.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedDistrict,
                  onChanged: (value) {
                    setState(() {
                      selectedDistrict = value!;
                    });
                  },
                  items: <String>[
                    'Thiruvananthapuram',
                    'Kollam',
                    'Pathanamthitta',
                    'Alappuzha',
                    'Kottayam',
                    'Idukki',
                    'Ernakulam',
                    'Thrissur',
                    'Palakkad',
                    'Malappuram',
                    'Kozhikode',
                    'Wayanad',
                    'Kannur',
                    'Kasaragod',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  value: selectedDisasterType,
                  onChanged: (value) {
                    setState(() {
                      selectedDisasterType = value!;
                    });
                  },
                  items: <String>[
                    'Select Disaster Type',
                    'Flood',
                    'Earthquake',
                    'Landslide',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // Add optional picture upload option here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Report'),
              onPressed: () {
                // Handle disaster reporting
                _reportToFirestore(selectedDistrict, selectedDisasterType);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _reportToFirestore(String district, String disasterType) async {
    try {
      await _firestore
          .collection('disaster_reports')
          .doc(district)
          .update({disasterType: FieldValue.increment(1)});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Disaster reported successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
