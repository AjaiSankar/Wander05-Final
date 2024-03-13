import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Itinerary extends StatefulWidget {
  final String destinationCountry;
  final String budget;
  final String travelStyle;
  final List interestsNew;
  final String accommodationType;
  final String transportationType;
  final String activityType;
  final String cuisineType;
  final String tripDuration;
  // final String language;

  const Itinerary({super.key, required this.destinationCountry, required this.budget, required this.travelStyle, required this.interestsNew, required this.accommodationType, required this.transportationType, required this.activityType, required this.cuisineType, required this.tripDuration});

  @override
  State<Itinerary> createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  String result='';
  final TextEditingController _controller = TextEditingController();
  // The OpenAI API endpoint
  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  // Replace 'YOUR_API_KEY' with your actual OpenAI API key
  final String apiKey = "apihere";

  // Function to make the POST request to the OpenAI API
  Future<void> fetchResponse(String destinationCountry, String budget, String travelStyle, List interestsNew, String accommodationType, String transportationType, String activityType,String cuisineType, String tripDuration) async {
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
            "content": "Generate a personalized travel itinerary for a trip to $destinationCountry with a budget of $budget. The traveler is interested in a $travelStyle vacation and enjoys $interestsNew. They are looking for $accommodationType accommodations and prefer $transportationType transportation. The itinerary should include $activityType activities and $cuisineType dining options. Please provide a detailed itinerary with daily recommendations for $tripDuration days, including suggested destinations, activities, and dining options.",
          }
        ],
      }),
    );
    if (response.statusCode == 200) {
  setState(() {
    result = jsonDecode(response.body)['choices'][0]['message']['content'];
  
  }); 
} else {
  // Print the response body for debugging purposes
  print('Request failed with status: ${response.statusCode}.');
  print('Response body: ${response.body}'); // Add this line to help debug
  throw Exception('Failed to load response: ${response.body}');
}
  }
    
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('ITINERARY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                   fetchResponse(
                    widget.destinationCountry,widget.budget , widget.travelStyle,widget.interestsNew, widget.accommodationType, widget.transportationType,widget.activityType,widget.cuisineType, widget.tripDuration
                   ) ;},
                  child: const Text('Send'),
                ),
                Text(result,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16
                  ),),
              ],
            ),
          ),
        ));
  }
}
