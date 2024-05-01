import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:wander05_final/Districts/Alappuzha/alappuzha.dart';
import 'package:wander05_final/Districts/Ernakulam/ernakulam.dart';
import 'package:wander05_final/Districts/Idukki/idukki.dart';
import 'package:wander05_final/Districts/Kannur/kannur.dart';
import 'package:wander05_final/Districts/Kasaragod/kasaragod.dart';
import 'package:wander05_final/Districts/Kollam/kollam.dart';
import 'package:wander05_final/Districts/Kottayam/kottayam.dart';
import 'package:wander05_final/Districts/Kozhikode/kozhikode.dart';
import 'package:wander05_final/Districts/Malappuram/malappuram.dart';
import 'package:wander05_final/Districts/Palakkad/palakkad.dart';
import 'package:wander05_final/Districts/Pathanamthitta/pathanamthitta.dart';
import 'package:wander05_final/Districts/Thrissur/thrissur.dart';
import 'package:wander05_final/Districts/Trivandum/trivandrum.dart';
import 'package:wander05_final/Districts/Wayanad/Wayanad.dart';
import 'package:wander05_final/UserProfilePage.dart';
import 'package:wander05_final/aiplans.dart';
import 'package:wander05_final/budget.dart';
import 'package:wander05_final/firebase_options.dart';
import 'package:wander05_final/it.dart';
import 'package:wander05_final/itinerary.dart';
import 'package:wander05_final/landing.dart';
import 'package:wander05_final/loader.dart';
import 'package:wander05_final/login.dart';
import 'package:wander05_final/Disaster_Alert/disaster.dart';
import 'package:wander05_final/myplans.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wander05',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
      routes: {
        '/login': (context) => LoginPage(),
        //'/itinerary': (context) => const Itinerary(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> images = [
    'images/f.jpg',
    'images/main2.jpg',
    'images/main3.jpg',
  ];

  final List<String> featureTexts = [
    '',
    '',
    '',
  ];

  final List<Map<String, dynamic>> weekendTrips = [
    {
      'image': 'images/wkt1.jpg',
      'name': '',
    },
    {
      'image': 'images/wkt2.jpg',
      'name': '',
    },
    {
      'image': 'images/wkt3.jpg',
      'name': '',
    },
  ];

  final List<Map<String, dynamic>> sunsets = [
    {
      'image': 'images/sun1.jpg',
      'name': '',
    },
    {
      'image': 'images/sun2.jpg',
      'name': '',
    },
    {
      'image': 'images/sun3.jpg',
      'name': '',
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

  // Function to handle logout
  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login page after logout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wander05',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[900],
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DistrictSearch(filteredDistricts, filterDistricts),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _signOut,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
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
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        featureTexts[index],
                        style: const TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
             Text(
                'Hi ${_auth.currentUser?.email ?? 'user'}, where do you want to go?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            GestureDetector(
              child: TextField(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: DistrictSearch(filteredDistricts, filterDistricts),
                  );
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search places',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/main6.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Aligns children vertically centered
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TripPreferencesPage()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 12, 84, 193)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)), // Adjust padding as needed
                        minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)), // Adjust size as needed
                      ),
                      child: const Text(
                        'Plan my Trip',
                        style: TextStyle(
                          fontSize: 18, // Adjust font size as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //  Container(
            //   margin: EdgeInsets.all(16.0),
            //   child: Column(
            //     children: [
            //       // Here you can dynamically generate cards for trip plans
            //       buildTripCard(
            //         // title: 'Trip 1',
            //         // description: 'Description of Trip 1',
            //         // Add more properties as needed
            //       ),
            //       buildTripCard(
            //         title: 'Trip 2',
            //         description: 'Description of Trip 2',
            //         // Add more properties as needed
            //       ),
            //       // Add more TripCard widgets as needed
            //     ],
            //   ),
            //  ),

            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Weekend trips near you',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: weekendTrips.length,
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                weekendTrips[index]['name'],
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
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



            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Beautiful Sunsets',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: weekendTrips.length,
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(sunsets[index]['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                weekendTrips[index]['name'],
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
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
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/main7.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Aligns children vertically centered
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    '',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TripPreferencesPage()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 12, 84, 193)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 10, horizontal: 20)), // Adjust padding as needed
                        minimumSize: MaterialStateProperty.all<Size>(const Size(150, 40)), // Adjust size as needed
                      ),
                      child: const Text(
                        'Show More',
                        style: TextStyle(
                          fontSize: 18, // Adjust font size as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

  bottomNavigationBar: ConvexAppBar(
  backgroundColor: const Color.fromARGB(255, 12, 84, 193),
  items: const [
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'My Trips'),
    TabItem(icon: Icons.add, title: 'New Trip'),
    TabItem(icon: Icons.hotel, title: 'Disasters'),
    TabItem(icon: Icons.file_copy, title: 'Ai Plans'),
  ],
  onTap: (int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisasterReportPage()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AiTripsPage()),
      );
    }
    else if (index == 1){
      Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => MyTripsPage(
    ),
  ),
);

    }
  },
),

    );
    
  }
  
  Widget buildTripCard(String title, String description) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            // Add more widgets to display additional information about the trip
          ],
        ),
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
        icon: const Icon(Icons.clear),
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
      icon: const Icon(Icons.arrow_back),
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
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
          title: Text(suggestionList[index]),
        );
      },
    );
  }

  Widget getDistrictPage(String district) {
    switch (district) {
      case 'Thiruvananthapuram':
        return TrivandrumPage();
      case 'Kollam':
        return KollamPage();
      case 'Alappuzha':
        return AlappuzhaPage();
      case 'Pathanamthitta':
        return PathanamthittaPage();
      case 'Kottayam':
        return KottayamPage();
      case 'Ernakulam':
        return ErnakulamPage();
      case 'Idukki':
        return IdukkiPage();
      case 'Thrissur':
        return ThrissurPage();
      case 'Palakkad':
        return PalakkadPage();
      case 'Kannur':
        return KannurPage();
      case 'Kasaragod':
        return KasaragodPage();
      case 'Kozhikode':
        return KozhikodePage();
      case 'Malappuram':
        return MalappuramPage();
      case 'Wayanad':
        return WayanadPage();
      default:
        return Container();
    }
  }
}
