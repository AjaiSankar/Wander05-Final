import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class TripPlanningPage extends StatefulWidget {
  const TripPlanningPage({super.key});

  @override
  _TripPlanningPageState createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> {
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _noOfDaysController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore the beauty of Kerala', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _budgetController,
                decoration: const InputDecoration(
                  labelText: 'Budget',
                  icon: Icon(Icons.attach_money, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30.0),
              TextField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination',
                  icon: Icon(Icons.location_on, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30.0),
              DateTimeField(
                controller: _startDateController,
                format: format,
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  return date;
                },
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30.0),
              DateTimeField(
                controller: _endDateController,
                format: format,
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  return date;
                },
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30.0),
              TextField(
                controller: _noOfDaysController,
                decoration: const InputDecoration(
                  labelText: 'Number of Days',
                  icon: Icon(Icons.calendar_today, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 30.0),
              const SizedBox(height: 50.0), // Added SizedBox to move the button down
              ElevatedButton(
                onPressed: () {
                  // Implement logic for trip planning
                  _planTrip();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Plan My Trip', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _planTrip() {
    // Implement your trip planning logic here
    String budget = _budgetController.text;
    String destination = _destinationController.text;
    String startDate = _startDateController.text;
    String endDate = _endDateController.text;
    String noOfDays = _noOfDaysController.text;

    // Print the trip details for now
    print('Budget: $budget, Destination: $destination, Start Date: $startDate, End Date: $endDate, Number of Days: $noOfDays');

    // Add logic to navigate to the next screen or perform further actions
  }
}
