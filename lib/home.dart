import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase authentication package

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> topDestinations = [
    'Paris',
    'Tokyo',
    'New York',
    'Rome',
    'Sydney',
    'London',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Travel App',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/travel_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore the World',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Plan your next adventure with us',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to itinerary generation page
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      textStyle: TextStyle(fontSize: 16.0),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('Generate Itinerary'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Top Destinations',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 180.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topDestinations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to destination details page
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage('assets/${topDestinations[index].toLowerCase()}_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          topDestinations[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Liked Destinations'),
              onTap: () {
                // Navigate to liked destinations page
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_car, color: Colors.blue),
              title: Text('Transport Booking'),
              onTap: () {
                // Navigate to transport booking page
              },
            ),
            ListTile(
              leading: Icon(Icons.hotel, color: Colors.green),
              title: Text('Hotel Booking'),
              onTap: () {
                // Navigate to hotel booking page
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny, color: Colors.orange),
              title: Text('Weather Alerts'),
              onTap: () {
                // Navigate to weather alerts page
              },
            ),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Disaster Alerts'),
              onTap: () {
                // Navigate to disaster alerts page
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Logout function
                FirebaseAuth.instance.signOut();
                // Navigate to login page
                // (Assuming you have a LoginPage widget)
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                textStyle: TextStyle(fontSize: 16.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}