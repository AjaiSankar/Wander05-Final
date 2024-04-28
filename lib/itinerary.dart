import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
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

  void fetchResponse() {}
}

class _ItineraryState extends State<Itinerary> {
  
  LatLng initialCenter = const LatLng(9.850, 76.271); // Default initial center
  double currentZoom = 9.0;
  String result = '';
  String _typingText = '';
  String _typingText1 = '';
  final TextEditingController _controller = TextEditingController();
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey = "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";
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
            "Generate a personalized travel itinerary for a trip from $startplace to $destinationCountry, considering a budget of ₹$budget. Ensure that the trip stays within the specified budget. The traveler prefers a $travelStyle vacation and enjoys $interestsNew. They seek $accommodationType accommodations and prefer $transportationType transportation. The itinerary should span $tripDuration days, featuring a mix of activities and dining options. For each day of the trip, provide detailed recommendations with morning, afternoon, and evening activities, along with their approximate costs. Include suggested destinations, activities, and dining spots. Ensure that the chosen path from $startplace to $destinationCountry is optimal, incorporating attractions along the route. Format the itinerary consistently as follows: Day X (Activity/Travel): Morning Activity: Cost: ₹ Afternoon Activity: Cost: ₹ Evening Activity: Cost: ₹. At the end of the itinerary, provide a list of all mentioned places along with their respective latitude and longitude coordinates for navigation purposes, ensuring they are listed in the correct order from the start to the destination along the optimal path. Estimated Total Cost: ₹. Approximate Costs: Accommodation: ₹ Transportation: ₹,Activities: ₹ per activity Dining: ₹ per meal. Make sure to print latitude and longitude of all mention places and destinations, the heading of it should be ""Destinations and Coordinates:"" and the format should be ""Place Name (Latitude, Longitude)"", it should only be at the end of plan"}
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
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      backgroundColor: Colors.blue,
      elevation: 0, // Remove elevation
    ),
    body: ListView(
      children: [
        Padding(
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
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(
                      _typingText.isEmpty ? 'Regenerate Itinerary' : '$_typingText...',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  // Save Plan button with animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add functionality to save plan
                        // For example: savePlan();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Button color
                        foregroundColor: Colors.white, // Text color
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Row(
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
              const SizedBox(height: 20),
              _buildItinerary(),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     List<String> destinations = []; // Define the 'destinations' variable
              //     _showMapDialog(context, destinations.cast<Map<String, LatLng>>());
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue, // Button color
              //     foregroundColor: Colors.white, // Text color
              //     padding: const EdgeInsets.all(16),
              //   ),
              //   child: const Text(
              //     'Show in Map',
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              const SizedBox(height: 20),
              _buildHotelsCarousel(),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: ConvexAppBar(
      backgroundColor: const Color.fromARGB(255, 12, 84, 193),
      items: const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.map, title: 'My Trips'),
        TabItem(icon: Icons.add, title: 'New Trip'),
        TabItem(icon: Icons.hotel, title: 'Bookings'),
        TabItem(icon: Icons.people, title: 'Profile'),
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
      height: 520,
      width: double.infinity, // Set a specific height
      child: HotelPage(destinationCountry: widget.destinationCountry),
    );
  }



  Widget _buildItinerary() {
  if (result.isEmpty) {
    return const Center(child: Text("No itinerary generated yet"));
  }

  List<String> days = result.split('Day ');
  days.removeAt(0); // Remove the first empty element

  List<Map<String, LatLng>> destinations = [];

  for (String day in days) {
    List<String> sections = day.split('Destinations and Coordinates:');
    print("Sections: $sections");
    print("Sections length: ${sections.length}");
    if (sections.length > 1) {
      String destinationsString = sections[1].trim();
      List<String> destinationsList = destinationsString.split('\n');
      print("Destinations: $destinationsList");
      print("Destinations length: ${destinationsList.length}");
      for (String destination in destinationsList) {
        List<String> parts = destination.split(RegExp(r'\(|\)'));
        print("Parts: $parts");
        print("Parts length: ${parts.length}");
        if (parts.length == 3) {
          // Extract latitude and longitude strings
          String latLongString = parts[1].trim();
          // Extract latitude and longitude values using a regular expression
          RegExp latLongPattern = RegExp(r'(-?\d+\.\d+),\s*(-?\d+\.\d+)');
          RegExpMatch? latLongMatch = latLongPattern.firstMatch(latLongString);
          print("LatLongMatch: $latLongMatch");
          print("LatLongMatch group 1: ${latLongMatch?.group(1)}");
          print("LatLongMatch group 2: ${latLongMatch?.group(2)}");
          if (latLongMatch != null) {
            double lat = double.parse(latLongMatch.group(1)!);
            double long = double.parse(latLongMatch.group(2)!);
            print("Latitude: $lat, Longitude: $long");
            destinations.add({
              parts[0].trim(): LatLng(lat, long),
            });
          }
        }
      }
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (String day in days) ...[
        _buildDayCard(day),
      ],
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          _showMapDialog(context, destinations);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue, // Button color
          foregroundColor: Colors.white, // Text color
          padding: const EdgeInsets.all(16),
        ),
        child: const Text(
          'Show in Map',
          style: TextStyle(fontSize: 18),
        ),
      ),
    ],
  );
}


  Widget _buildDayCard(String day) {
    List<String> sections = day.split(RegExp(r'Morning|Afternoon|Evening'));
    String heading = sections[0].trim();
    List<String> activities = sections.sublist(1);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: isLastActivity ? null : const Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Text(
          activityContent,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 9, 11, 13),
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
          title: const Text('Detailed Plan'),
          content: Text(activityContent),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showMapDialog(BuildContext context, List<Map<String, LatLng>> destinations) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          height: 500,
          child: FlutterMap(
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: currentZoom,
              interactionOptions: const InteractionOptions(
                enableScrollWheel: true,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/vivekunni/clv9da5t200bw01o081rx6qts/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoidml2ZWt1bm5pIiwiYSI6ImNsdjNrY29hbTB1bTUyanJ5MjZ1NmFtcXkifQ.9q187S7ZwqH6hKF8GkILXQ',
                additionalOptions: const {
                  'accessToken':
                      'pk.eyJ1Ijoidml2ZWt1bm5pIiwiYSI6ImNsdjNrY29hbTB1bTUyanJ5MjZ1NmFtcXkifQ.9q187S7ZwqH6hKF8GkILXQ',
                  'id': 'mapbox://styles/vivekunni/clv9da5t200bw01o081rx6qts'
                },
              ),
              MarkerLayer(
                markers: [
                  // User's location marker
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
                  // Destination markers
                  ...destinations.map((destination) => Marker(
                    width: 50.0,
                    height: 50.0,
                    point: destination.values.first,
                    child: Container(
                      child: Image.asset("assets/R.png"),
                    ),
                  )).toList(),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Constructing Google Maps URL
              String baseUrl = 'https://www.google.com/maps/dir/';
List<String> waypoints = [];

for (var dest in destinations) {
  waypoints.add('${dest.values.first.latitude},${dest.values.first.longitude}');
}

String joinedWaypoints = waypoints.join('/');

String finalUrl = baseUrl + joinedWaypoints;
print("Google Maps URL: $finalUrl");
launchUrl(Uri.parse(finalUrl));
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

