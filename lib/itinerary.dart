import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  const Itinerary({
    Key? key,
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
  _ItineraryState createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  String result = '';
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey = "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";

  Future<void> fetchResponse() async {
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
                "Generate a personalized travel itinerary for a trip to ${widget.destinationCountry} with a budget of ${widget.budget}. The traveler is interested in a ${widget.travelStyle} vacation and enjoys ${widget.interestsNew.join(', ')}. They are looking for ${widget.accommodationType} accommodations and prefer ${widget.transportationType} transportation. The itinerary should include ${widget.activityType} activities and ${widget.cuisineType} dining options. Please provide a detailed itinerary with daily recommendations for ${widget.tripDuration} days, including suggested destinations, activities, and dining options.",
          }
        ],
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body)['choices'][0]['message']['content'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception('Failed to load response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ITINERARY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: fetchResponse,
                child: const Text('Generate Itinerary'),
              ),
              const SizedBox(height: 20),
              Text(
                'Itinerary:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: result.isEmpty
                    ? Text(
                        'No itinerary generated yet',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    : Text(
                        result,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}