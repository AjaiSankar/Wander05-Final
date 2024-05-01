import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wander05_final/budget.dart';
import 'package:wander05_final/budgetno.dart';
import 'package:wander05_final/printPlan.dart';

class AiTripsPage extends StatelessWidget {
  final List<String> images = ['plan1', 'plan2', 'plan3', 'plan4', 'plan5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Trip Plans'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: fetchRandomPlans(),
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
                        //_showFullPlan(context, plans[index]['plan']);
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
  if (tripId != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CannotManageBudgetPage(),
      ),
    );
  } else {
    // Handle the case where tripId is null, such as showing an error message or navigating to a default page
  }

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
                                            print("Plan: "+ plans[index]['plan']);
            // Navigate to PrintPlans class and pass the argument 'pass'
            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => PrintPlans(
  
      plan: plans[index]['plan'],
      dplace: destination,
      splace: startPlace,
    ),
  ),
);
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

  Future<List<DocumentSnapshot>> fetchRandomPlans() async {
  try {
    // Reference to the allplans collection
    CollectionReference allPlansCollectionRef = FirebaseFirestore.instance.collection('allplans');

    // Fetch all plans
    QuerySnapshot querySnapshot = await allPlansCollectionRef.get();

    // Shuffle the list of plans
    List<DocumentSnapshot> allPlans = querySnapshot.docs;
    allPlans.shuffle();

    // Select the first 10 plans or less if there are fewer plans available
    List<DocumentSnapshot> randomPlans = allPlans.take(10).toList();

    return randomPlans;
  } catch (e) {
    print('Error fetching random plans: $e');
    return [];
  }
}

//   void _showFullPlan(BuildContext context, String plan) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Full Plan'),
//           content: SingleChildScrollView(
//             child: Text(plan),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//             // Navigate to PrintPlans class and pass the argument 'pass'
//             Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => PrintPlans(
//       plan: plan,
//       destination: destination,
//       startPlace: startPlace,
//     ),
//   ),
// );
//           },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}