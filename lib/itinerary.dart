import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
  String result = '';
  String _typingText = '';
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
      _typingText = 'Generating itinerary...';
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
                "Generate a personalized travel itinerary for a trip to $destinationCountry starting from $startplace with a budget of $budget. The traveler is interested in a $travelStyle vacation and enjoys $interestsNew. They are looking for $accommodationType accommodations and prefer $transportationType transportation. The itinerary should include $activityType activities and $cuisineType dining options. Please provide a detailed itinerary with daily recommendations for $tripDuration days, including suggested destinations, activities, and dining options.Give names for each accomodation and food spots to take food Also make sure that the places and path chosen from $startplace to $destinationCountry is optimal such that choose places on the path from $startplace to $destinationCountry also. The format for the plan should be well structured so that it can be easily designed to form a beautiful ui for a travel planning app. include time also",
          }
        ],
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body)['choices'][0]['message']['content'];
        _typingText = '';
      });
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
        title: const Text(
          'ITINERARY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                primary: Colors.blue, // Button color
                onPrimary: Colors.white, // Text color
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _typingText.isEmpty ? 'Generate Itinerary' : '$_typingText...',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Generated Itinerary:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            _buildItinerary(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Save Plan
                  },
                  icon: Icon(Icons.save),
                  label: Text('Save Plan'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Button color
                    onPrimary: Colors.white, // Text color
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Regenerate Plan
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Regenerate Plan'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange, // Button color
                    onPrimary: Colors.white, // Text color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItinerary() {
    if (result.isEmpty) {
      return Text("No itinerary generated yet");
    }

    List<String> days = result.split('Day ');
    days.removeAt(0);

    return Column(
      children: days.map((day) {
        return _buildDayCard(day);
      }).toList(),
    );
  }

  Widget _buildDayCard(String dayContent) {
  List<String> sections = dayContent.split(RegExp(r'Morning|Afternoon|Evening'));

  return Card(
    margin: EdgeInsets.symmetric(vertical: 10),
    elevation: 3,
    color: Colors.blue.shade50,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sections.first.trim(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.blue.shade900,
            ),
          ),
          Divider(color: Colors.blue.shade900),
          for (int i = 1; i < sections.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _cleanText(sections[i].trim()),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

String _cleanText(String text) {
  // Remove asterisks and unwanted symbols
  return text.replaceAll(RegExp(r'[*~]'), '').replaceAll('&nbsp;', ' ');
}

}
