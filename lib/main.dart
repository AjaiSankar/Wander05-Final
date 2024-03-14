import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:wander05_final/Districts/Trivandum/trivandrum.dart';
import 'package:wander05_final/Districts/Trivandum/tvmexplore.dart';
import 'package:wander05_final/it.dart';
import 'package:wander05_final/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander05',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TripPreferencesPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'images/f.jpg',
    'images/main2.jpg',
    'images/main3.jpg',
  ];

  final List<String> featureTexts = [
    'Feature 1: Discover new places',
    'Feature 2: Plan your trips',
    'Feature 3: Share experiences',
  ];

  final List<Map<String, dynamic>> weekendTrips = [
    {
      'image': 'images/f.jpg',
      'name': 'Trip 1',
    },
    {
      'image': 'images/main2.jpg',
      'name': 'Trip 2',
    },
    {
      'image': 'images/main3.jpg',
      'name': 'Trip 3',
    },
  ];

  List<String> districts = [
    'Thiruvananthapuram',
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
    'Kasaragod',
  ];

  List<String> filteredDistricts = [];

  @override
  void initState() {
    filteredDistricts.addAll(districts);
    super.initState();
  }

  void filterDistricts(String query) {
    setState(() {
      filteredDistricts = districts
          .where((district) =>
              district.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wander05',
          style: TextStyle(
            color: Colors.white, // Set text color
            fontSize: 20, // Set text size
          ),
        ),
        backgroundColor: Colors.blue[900], // Set background color
        elevation: 4, // Add elevation (shadow)
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white), // Set icon color
            onPressed: () {
              showSearch(
                context: context,
                delegate: DistrictSearch(filteredDistricts, filterDistricts),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8), // Add padding to the whole body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider.builder(
              itemCount: images.length,
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Add padding to the text
                      child: Text(
                        featureTexts[index],
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Hi user, where do you want to go?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
           GestureDetector(
  child: TextField(
    onTap: () {
    showSearch(
      context: context,
      delegate: DistrictSearch(filteredDistricts, filterDistricts),
    );
  },
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.search),
      hintText: 'Search places',
      border: OutlineInputBorder(),
    ),
  ),
),

            SizedBox(height: 20),
            Container(
              width: double.infinity, // Take full width of the screen
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/main6.jpg'),
                  fit: BoxFit.cover, // Cover the full container area
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0), // Add padding to the text
                    child: Text(
                      'Plan your next trip', // Removed the "with zero effort" part for simplicity
                      style: TextStyle(
                        fontSize: 32, // Increased font size for a stronger emphasis
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing between text and button
                  Text(
                    'With our easy-to-use app planning your\n next adventure is a breeze!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40), // Increase spacing between text and button
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 12, 84, 193)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(Size(30, 60)),
                    ),
                    child: Container(
                      height: 60, // Increase button height
                      child: Center(
                        child: Text(
                          'Plan my Trip',
                          style: TextStyle(
                            fontSize: 20, // Increased button text size
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 16.0), // Add padding to the left of the text
              child: Text(
                'Weekend trips near you',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: weekendTrips.length,
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(weekendTrips[index]['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                weekendTrips[index]['name'],
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                child: Text('Explore'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color.fromARGB(255, 12, 84, 193),
        items: [
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
}

class DistrictSearch extends SearchDelegate<String> {
  final List<String> districts;
  final Function(String) onFilter;

  DistrictSearch(this.districts, this.onFilter);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onFilter('');
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? districts
        : districts.where((district) {
            return district.toLowerCase().startsWith(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // Navigate to the respective district page with a fade transition
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: getDistrictPage(suggestionList[index]),
                  );
                },
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
                transitionDuration: Duration(milliseconds: 500), // Adjust the duration as needed
              ),
            );
          },
          title: Text(suggestionList[index]),
        );
      },
    );
  }

  Widget getDistrictPage(String district) {
    // Assuming you have created separate pages for each district
    // You can replace these with your actual district page widgets
    switch (district) {
      case 'Thiruvananthapuram':
        return TrivandrumPage();
      case 'Kollam':
        return TrivandrumPage();
      // Add cases for other districts
      default:
        return Container(); // Return a default container or page if the district page is not available
    }
  }
}
