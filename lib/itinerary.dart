import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wander05_final/hotel.dart';

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
  
}

class _ItineraryState extends State<Itinerary> {
  
  LatLng initialCenter = LatLng(9.850, 76.271); // Default initial center
  double currentZoom = 9.0;
  String result = '';
  String _typingText = '';
  final TextEditingController _controller = TextEditingController();
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey = "API KEY HERE";
  void initState() {
    super.initState();
    _getLocation();
  }
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
      _typingText = 'Generating itinerary';
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
                "Generate a personalized travel itinerary for a trip to $destinationCountry starting from $startplace with a budget of $budget. The traveler is interested in a $travelStyle vacation and enjoys $interestsNew. They are looking for $accommodationType accommodations and prefer $transportationType transportation. The itinerary should include $activityType activities and $cuisineType dining options. Please provide a detailed itinerary with daily recommendations for $tripDuration days, including suggested destinations, activities, and dining options. Give names for each accommodation and food spots to take food. Also make sure that the places and path chosen from $startplace to $destinationCountry is optimal such that choose places on the path from $startplace to $destinationCountry also. The format for the plan should be as follows: Day(Activity/Travel), Morning Activity(this should be the subheading), Afternoon Activity(this should be the subheading), Evening Activity",
          }
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
    return Scaffold(
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
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
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button color
                          foregroundColor: Colors.white, // Text color
                          padding: EdgeInsets.all(16),
                        ),
                        child: Text(
                          _typingText.isEmpty ? 'Regenerate Itinerary' : '$_typingText...',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      // Save Plan button with animation
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add functionality to save plan
                            // For example: savePlan();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Button color
                            foregroundColor: Colors.white, // Text color
                            padding: EdgeInsets.all(16),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.save),
                              SizedBox(width: 8),
                              Text(
                                'Save Plan',
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                _showMapDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.all(16),
              ),
              child: Text(
                'Show in Map',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          _buildHotelsCarousel(),
        ],
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
    );
  }

  Future<void> _getLocation() async {
    try {
      Position position = await _determinePosition();
      setState(() {
        initialCenter = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error getting location: $e');
      // Handle errors here
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget _buildHotelsCarousel() {
  return SizedBox(
    height: 300, // Set a specific height
    child: HotelPage(),
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
        for (String day in days) _buildDayCard(day),
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

  void _showMapDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text("Map"),
          content: SizedBox(
            width: double.maxFinite,
            height: 500,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: currentZoom,
                interactionOptions: InteractionOptions(
                  enableScrollWheel: true,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/vivekunni/clv9da5t200bw01o081rx6qts/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoidml2ZWt1bm5pIiwiYSI6ImNsdjNrY29hbTB1bTUyanJ5MjZ1NmFtcXkifQ.9q187S7ZwqH6hKF8GkILXQ',
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1Ijoidml2ZWt1bm5pIiwiYSI6ImNsdjNrY29hbTB1bTUyanJ5MjZ1NmFtcXkifQ.9q187S7ZwqH6hKF8GkILXQ',
                    'id': 'mapbox://styles/vivekunni/clv9da5t200bw01o081rx6qts'
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: initialCenter,
                      child: Container(
                        child: Image.asset(
                          "assets/gps.png",
                        ),
                      ),
                    ),
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: LatLng(11.850, 76.271),
                      child: Container(
                        child: Image.asset(
                          "assets/R.png",
                        ),
                      ),
                    ),
                    Marker(
                      width: 50.0,
                      height: 50.0,
                      point: LatLng(9.850, 76.271),
                      child: Container(
                        child: Image.asset(
                          "assets/R.png",
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Navigate"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
