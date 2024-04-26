import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Itinerary extends StatefulWidget {
  final String startplace;
  final String destinationCountry;
  final String budget;
  final String travelStyle;
  final List interestsNew;
  final String accommodationType;
  final String transportationType;
  final String activityType;
  final String cuisineType;
  final String tripDuration;

  const Itinerary({
    Key? key,
    required this.startplace,
    required this.destinationCountry,
    required this.budget,
    required this.travelStyle,
    required this.interestsNew,
    required this.accommodationType,
    required this.transportationType,
    required this.activityType,
    required this.cuisineType,
    required this.tripDuration,
  }) : super(key: key);

  @override
  State<Itinerary> createState() => _ItineraryState();

  void fetchResponse() {}
}

class _ItineraryState extends State<Itinerary> {
  String result = '';
  String _typingText = '';
  String _typingText1 = '';
  final TextEditingController _controller = TextEditingController();
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey = "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";

  Future<void> fetchResponse(
    String startplace,
    String destinationCountry,
    String budget,
    String travelStyle,
    List interestsNew,
    String accommodationType,
    String transportationType,
    String activityType,
    String cuisineType,
    String tripDuration,
  ) async {
    setState(() {
      _typingText = 'Generating\nitinerary';
      _typingText1 = 'Creating your plan..';
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful assistant."
          },
          {
            "role": "user",
            "content":
            "Generate a personalized travel itinerary for a trip from $startplace to $destinationCountry, considering a budget of ₹$budget. Ensure that the trip stays within the specified budget. The traveler prefers a $travelStyle vacation and enjoys $interestsNew. They seek $accommodationType accommodations and prefer $transportationType transportation. The itinerary should span $tripDuration days, featuring a mix of activities and dining options. For each day of the trip, provide detailed recommendations with morning, afternoon, and evening activities, along with their approximate costs. Include suggested destinations, activities, and dining spots. Ensure that the chosen path from $startplace to $destinationCountry is optimal, incorporating attractions along the route. Format the itinerary consistently as follows: Day X (Activity/Travel): Morning Activity: Cost: ₹ Afternoon Activity: Cost: ₹ Evening Activity: Cost: ₹. At the end of the itinerary, provide a list of all mentioned places along with their respective latitude and longitude coordinates for navigation purposes, ensuring they are listed in the correct order from the start to the destination along the optimal path. Estimated Total Cost: ₹. Approximate Costs: Accommodation: ₹ Transportation: ₹,Activities: ₹ per activity Dining: ₹ per meal. MAke sure to print latitude and longitude of all mention places and destinations"}
        ],
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body)['choices'][0]['message']['content'];
        _typingText = '';
      });

      // Print the response to the console
      print("Response: $result");
    } else {
      setState(() {
        _typingText = '';
      });
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception('Failed to load response: ${response.body}');
    }
  }
@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      Scaffold(
        appBar: AppBar(
          title: Text(
            widget.destinationCountry,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: Colors.blue,
          elevation: 0, // Remove elevation
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Show loading animation

                      // Fetch response
                      fetchResponse(
                        widget.startplace,
                        widget.destinationCountry,
                        widget.budget,
                        widget.travelStyle,
                        widget.interestsNew,
                        widget.accommodationType,
                        widget.transportationType,
                        widget.activityType,
                        widget.cuisineType,
                        widget.tripDuration,
                      ).then((_) {
                        // Hide loading animation after fetching data
                        setState(() {
                          _typingText1 = ''; // Clear loading text
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Button color
                      onPrimary: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      elevation: 3, // Button elevation
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          _typingText.isEmpty ? 'Regenerate\n Itinerary' : _typingText,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center, // Center text
                        )
                      ],
                    ),
                  ),
                  // Save Plan button with animation
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: () async {
                        // onPressed callback logic for saving the plan
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Button color
                        onPrimary: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        elevation: 3, // Button elevation
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 8),
                          Text(
                            'Save\nPlan',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildItinerary(),
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: const Color.fromARGB(255, 12, 84, 193),
          items: [
            const TabItem(icon: Icons.home, title: 'Home'),
            const TabItem(icon: Icons.map, title: 'My Trips'),
            const TabItem(icon: Icons.add, title: 'New Trip'),
            const TabItem(icon: Icons.hotel, title: 'Bookings'),
            const TabItem(icon: Icons.people, title: 'Profile'),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
      ),
      if (_typingText1.isNotEmpty) // Show loading animation overlay if _typingText is not empty
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent background
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // Loading indicator
                  SizedBox(height: 10),
                  Text(
                    _typingText1,
                    style: TextStyle(
                      color: Color.fromARGB(255, 18, 5, 200),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  );
}




Widget _buildItinerary() {
  if (result.isEmpty) {
    return Center(child: Text("No itinerary generated yet"));
  }

  List<String> days = result.split('Day ');
  days.removeAt(0);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (String day in days)
        _buildDayCard(day),
    ],
  );
}

Widget _buildDayCard(String day) {
  List<String> sections = day.split(RegExp(r'Morning|Afternoon|Evening'));
  String heading = sections[0].trim();
  List<String> activities = sections.sublist(1);

  return Card(
    margin: EdgeInsets.symmetric(vertical: 8),
    elevation: 3,
    color: Colors.blue.shade50,
    child: ExpansionTile(
      title: Text(
        heading,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.blue.shade900,
        ),
      ),
      children: [
        for (var i = 0; i < activities.length; i++)
          _buildActivityCard(activities[i].trim(), i + 1 == activities.length),
      ],
    ),
  );
}

Widget _buildActivityCard(String activityContent, bool isLastActivity) {
  return GestureDetector(
    onTap: () {
      _showDetailedPlan(context, activityContent);
    },
    child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLastActivity ? null : Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Text(
        activityContent,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 9, 11, 13),
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}



void _showDetailedPlan(BuildContext context, String activityContent) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Detailed Plan'),
        content: Text(activityContent),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
}
