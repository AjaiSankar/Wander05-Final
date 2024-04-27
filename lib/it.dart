import 'package:flutter/material.dart';
import 'package:wander05_final/itinerary.dart';

class TripPreferencesPage extends StatefulWidget {
  @override
  _TripPreferencesPageState createState() => _TripPreferencesPageState();
}

class _TripPreferencesPageState extends State<TripPreferencesPage> {
  int _currentStep = 0;
  bool _isLoading = false;

  String? startplace;
  String? destinationCountry;
  String? budget;
  String? travelStyle;
  List<String> interests = [];
  String? accommodationType;
  String? transportationType;
  String? activityType;
  String? cuisineType;
  String? tripDuration;

  List<String> travelStyles = ['Adventure', 'Relaxation', 'Culture', 'Sightseeing'];
  List<String> accommodationTypes = ['Hotel', 'Resort', 'Hostel', 'Vacation Rental'];
  List<String> transportationTypes = ['Public Transport', 'Rental Car', 'Taxi', 'Bicycle'];
  List<String> activityTypes = ['Outdoor', 'Indoor', 'Sightseeing', 'Cultural'];
  List<String> cuisineTypes = ['Traditional', 'International', 'Vegetarian', 'Vegan'];
  
  List<String> keralaDistricts = [
    'Trivandrum',
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
    'Kasaragod'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Preferences'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stepper(
                  type: StepperType.vertical,
                  currentStep: _currentStep,
                  onStepContinue: () {
                    if (_currentStep < 9) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      _generatePlan();
                    }
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() {
                        _currentStep -= 1;
                      });
                    }
                  },
                  steps: [
                    Step(
                      title: Text('Start Place'),
                      content: _buildDropdownField(
                        label: 'Start Place',
                        value: startplace,
                        onChanged: (value) {
                          setState(() {
                            startplace = value;
                          });
                        },
                        items: keralaDistricts,
                      ),
                    ),
                    Step(
                      title: Text('Destination Place'),
                      content: _buildDropdownField(
                        label: 'Destination Place',
                        value: destinationCountry,
                        onChanged: (value) {
                          setState(() {
                            destinationCountry = value;
                          });
                        },
                        items: keralaDistricts,
                      ),
                    ),
                    Step(
                      title: Text('Budget'),
                      content: _buildTextField(
                        label: 'Budget',
                        hint: 'Enter your budget',
                        onChanged: (value) {
                          setState(() {
                            budget = value;
                          });
                        },
                      ),
                    ),
                    Step(
                      title: Text('Travel Style'),
                      content: _buildDropdownField(
                        label: 'Travel Style',
                        value: travelStyle,
                        onChanged: (value) {
                          setState(() {
                            travelStyle = value!;
                          });
                        },
                        items: travelStyles.toSet().toList(),
                      ),
                    ),
                    Step(
                      title: Text('Interests'),
                      content: _buildCheckboxList(
                        label: 'Interests',
                        values: interests,
                        onChanged: (value) {
                          setState(() {
                            if (interests.contains(value)) {
                              interests.remove(value);
                            } else {
                              interests.add(value);
                            }
                          });
                        },
                        items: ['Nature', 'History', 'Food', 'Shopping'],
                      ),
                    ),
                    Step(
                      title: Text('Accommodation Type'),
                      content: _buildDropdownField(
                        label: 'Accommodation Type',
                        value: accommodationType,
                        onChanged: (value) {
                          setState(() {
                            accommodationType = value!;
                          });
                        },
                        items: accommodationTypes.toSet().toList(),
                      ),
                    ),
                    Step(
                      title: Text('Transportation Type'),
                      content: _buildDropdownField(
                        label: 'Transportation Type',
                        value: transportationType,
                        onChanged: (value) {
                          setState(() {
                            transportationType = value!;
                          });
                        },
                        items: transportationTypes.toSet().toList(),
                      ),
                    ),
                    Step(
                      title: Text('Activity Type'),
                      content: _buildDropdownField(
                        label: 'Activity Type',
                        value: activityType,
                        onChanged: (value) {
                          setState(() {
                            activityType = value!;
                          });
                        },
                        items: activityTypes.toSet().toList(),
                      ),
                    ),
                    Step(
                      title: Text('Cuisine Type'),
                      content: _buildDropdownField(
                        label: 'Cuisine Type',
                        value: cuisineType,
                        onChanged: (value) {
                          setState(() {
                            cuisineType = value!;
                          });
                        },
                        items: cuisineTypes.toSet().toList(),
                      ),
                    ),
                    Step(
                      title: Text('Trip Duration'),
                      content: _buildTextField(
                        label: 'Trip Duration',
                        hint: "Enter your trip duration",
                        onChanged: (value) {
                          setState(() {
                            tripDuration = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _generatePlan() {
    setState(() {
      _isLoading = true;
    });
    // Simulate a delay to show loading indicator
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Itinerary(
            startplace: startplace!,
            destinationCountry: destinationCountry!,
            budget: budget!,
            travelStyle: travelStyle!,
            interestsNew: interests,
            accommodationType: accommodationType!,
            transportationType: transportationType!,
            activityType: activityType!,
            cuisineType: cuisineType!,
            tripDuration: tripDuration!,
          ),
        ),
      ).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  Widget _buildDropdownField({
    required String label,
    String? value,
    required void Function(String?) onChanged,
    List<String>? items,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items?.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required void Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCheckboxList({
    required String label,
    required List<String> values,
    required void Function(String) onChanged,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 5.0),
        Wrap(
          spacing: 10.0,
          children: items.map((item) {
            return FilterChip(
              label: Text(item),
              selected: values.contains(item),
              onSelected: (selected) {
                onChanged(item);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

