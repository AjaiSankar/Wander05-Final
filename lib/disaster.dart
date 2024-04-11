import 'package:flutter/material.dart';

class DisasterPage extends StatefulWidget {
  @override
  _DisasterPageState createState() => _DisasterPageState();
}

class _DisasterPageState extends State<DisasterPage> {
  List<String> reportedDisasters = [];
  Map<String, int> disasterCounts = {};

  // Function to report a disaster
  void reportDisaster(String district, String type, String intensity) {
    setState(() {
      String disaster = '$district - $type ($intensity)';
      reportedDisasters.add(disaster);
      disasterCounts.update(disaster, (value) => value + 1, ifAbsent: () => 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disaster Alerts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reportedDisasters.length,
              itemBuilder: (context, index) {
                String disaster = reportedDisasters[index];
                int count = disasterCounts[disaster] ?? 0;
                return count > 5 ? _buildDisasterCard(disaster, count) : SizedBox();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Open a form to report a disaster
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String? district = '';
                    String? type = '';
                    String intensity = '';
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: Text('Report Disaster'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'District',
                                ),
                                value: district,
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
                                  // Add more districts if needed
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    district = value;
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Type',
                                ),
                                value: type,
                                items: <String>[
                                  'Earthquake',
                                  'Flood',
                                  'Hurricane',
                                  'Tornado',
                                  'Wildfire',
                                  // Add more disaster types as needed
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    type = value;
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Intensity',
                                ),
                                value: intensity,
                                items: <String>[
                                  'Low',
                                  'Medium',
                                  'High',
                                  // Add more intensity levels as needed
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    intensity = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Add reported disaster
                                if (district.isNotEmpty && type.isNotEmpty && intensity.isNotEmpty) {
                                  reportDisaster(district, type, intensity);
                                  Navigator.pop(context);
                                } else {
                                  // Show error message if any field is empty
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Please fill all the fields'),
                                    ),
                                  );
                                }
                              },
                              child: Text('Report'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: Text('Report Disaster'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisasterCard(String disaster, int count) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(disaster),
        subtitle: Text('Reported by $count people'),
        leading: Icon(Icons.warning),
      ),
    );
  }
}
