import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander05_final/budget.dart';

class MyTripsPage extends StatelessWidget {
  final List<String> images = ['main1', 'main2', 'main3', 'main4', 'main5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: fetchSavedPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError || snapshot.data == null) {
              return Center(
                child: Text('Error: Unable to fetch data.'),
              );
            } else {
              List<DocumentSnapshot> plans = snapshot.data!;
              if (plans.isEmpty) {
                return Center(
                  child: Text('No saved plans found.'),
                );
              } else {
                return ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    // Randomly select an image
                    String imageUrl = images[Random().nextInt(images.length)];
                    // Get the start place and destination from the document data
                    String startPlace = plans[index]['startplace'];
                    String destination = plans[index]['destination'];

                    return GestureDetector(
                      onTap: () {
                        // Handle card tap
                        print('Tapped on card: $index');
                        // Display the full plan
                        print('Full plan: ${plans[index]['plan']}');
                        _showFullPlan(context, plans[index]['plan']);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              child: Image.asset(
                                'images/$imageUrl.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 150,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$startPlace - $destination',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 120, // Adjust width as needed
                                        child: ElevatedButton(
                                          onPressed: () {
    // Get the trip ID from the DocumentSnapshot
    String? tripId = plans.isNotEmpty ? plans[index].id : null; // Assuming the trip ID is the document ID
// if (tripId != null) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => BudgetTrackerPage(: tripId,),
//     ),
//   );
// } else {
//   // Handle the case when tripId is null, for example, display an error message
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text('Trip ID is not valid.'),
//     ),
//   );
// }

  },
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(255, 49, 51, 214),
                                            textStyle: TextStyle(color: Colors.white),
                                          ),
                                          child: Text(
                                            'Budget Manage',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 120, // Adjust width as needed
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // View the plan
                                            _showFullPlan(context, plans[index]['plan']);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                            textStyle: TextStyle(color: Colors.white),
                                          ),
                                          child: Text(
                                            'View Plan',
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> fetchSavedPlans() async {
    try {
      // Get the current user's UID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Reference to the user's plans collection
      CollectionReference plansCollectionRef = FirebaseFirestore.instance
          .collection('itinerary')
          .doc(userId)
          .collection('plans');

      // Fetch the user's plans
      QuerySnapshot querySnapshot = await plansCollectionRef.get();

      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching saved plans: $e');
      return [];
    }
  }

  void _showFullPlan(BuildContext context, String plan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Full Plan'),
          content: SingleChildScrollView(
            child: Text(plan),
          ),
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
