import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; // for jsonDecode
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart'; // import the url_launcher package

class HotelPage extends StatefulWidget {
  final String destinationCountry;

  HotelPage({required this.destinationCountry});

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  List<Map<String, dynamic>> hotels = [];

  @override
  void initState() {
    super.initState();
    loadHotelsFromAssets();
  }

  Future<void> loadHotelsFromAssets() async {
    final String fileName = '${widget.destinationCountry.toLowerCase()}.json';
    print(fileName);
    print(fileName);
    print(fileName);
    print(fileName);
    final jsonString = await rootBundle.loadString('assets/hotels/$fileName');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    setState(() {
      hotels = jsonData.map((data) => data as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the original AppBar
        child: Container(), // Empty container to occupy the space
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adjust vertical padding
            child: Text(
              'Hotels in ${widget.destinationCountry}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17.5, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Add fontWeight if needed
                // Add more styling properties as needed
              ),
            ),
          ),
          hotels.isNotEmpty
              ? CarouselSlider.builder(
                  itemCount: hotels.length,
                  options: CarouselOptions(
                    aspectRatio: 16 / 12,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    enlargeCenterPage: false,
                    viewportFraction: 0.45,
                  ),
                  itemBuilder: (context, index, _) {
                    return HotelCard(hotel: hotels[index]);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            if (hotel['image'] != null)
              SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    hotel['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                _launchUrl(hotel['url']);
              },
              child: Text(
                hotel['name'] ?? '',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(hotel['location'] ?? ''),
            const Divider(thickness: 1.0),
            Text(hotel['review'] ?? ''),
          ],
        ),
      ),
    );
  }
}

void _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  print('Launching URL: $uri');
  try {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  } on PlatformException catch (e) {
    print('Error launching URL: $e');
  }
}