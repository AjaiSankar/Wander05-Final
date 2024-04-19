import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisasterReportPage extends StatefulWidget {
  @override
  _DisasterReportPageState createState() => _DisasterReportPageState();
}

class _DisasterReportPageState extends State<DisasterReportPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String kottayamId = "Thiruvananthapuram";
  int floodCount = 0;
  int earthquakeCount = 0;
  int landslideCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flood Count: $floodCount'),
            Text('Earthquake Count: $earthquakeCount'),
            Text('Landslide Count: $landslideCount'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementFloodCount,
              child: Text('Report Flood'),
            ),
            ElevatedButton(
              onPressed: _incrementEarthquakeCount,
              child: Text('Report Earthquake'),
            ),
            ElevatedButton(
              onPressed: _incrementLandslideCount,
              child: Text('Report Landslide'),
            ),
          ],
        ),
      ),
    );
  }

  void _incrementFloodCount() {
    _firestore.collection('disaster_reports').doc(kottayamId).update({
      'Flood': FieldValue.increment(1),
    }).then((value) {
      setState(() {
        floodCount++;
      });
    }).catchError((error) {
      print("Failed to update Flood count: $error");
    });
  }

  void _incrementEarthquakeCount() {
    _firestore.collection('disaster_reports').doc(kottayamId).update({
      'Earthquake': FieldValue.increment(1),
    }).then((value) {
      setState(() {
        earthquakeCount++;
      });
    }).catchError((error) {
      print("Failed to update Earthquake count: $error");
    });
  }

  void _incrementLandslideCount() {
    _firestore.collection('disaster_reports').doc(kottayamId).update({
      'Landslide': FieldValue.increment(1),
    }).then((value) {
      setState(() {
        landslideCount++;
      });
    }).catchError((error) {
      print("Failed to update Landslide count: $error");
    });
  }
}
