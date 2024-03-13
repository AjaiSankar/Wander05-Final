import 'package:flutter/material.dart';
import 'package:wander05_final/Districts/Trivandum/tvmexplore.dart';

// Add a class to represent a user review
class UserReview {
  final String userImage;
  final String reviewText;
  final int rating; // Assuming ratings are integers for simplicity

  UserReview({
    required this.userImage,
    required this.reviewText,
    required this.rating,
  });
}

class TrivandrumPage extends StatelessWidget {
  int _selectedIndex = 0;
  // Assuming these are some sample user reviews
  final List<UserReview> userReviews = [
    UserReview(
      userImage: 'images/user1.jpg',
      reviewText: 'Awesome place! Loved the scenery.',
      rating: 5,
    ),
    UserReview(
      userImage: 'images/user2.jpg',
      reviewText: 'Great experience, would definitely recommend.',
      rating: 4,
    ),
    // Add more reviews as needed
  ];

  // Method to calculate the overview of total reviews
  Map<int, int> calculateReviewOverview() {
    Map<int, int> overview = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in userReviews) {
      overview[review.rating];
    }
    return overview;
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the review overview
    Map<int, int> reviewOverview = calculateReviewOverview();

    return Scaffold(
      appBar: AppBar(
        title: Text('Trivandrum Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Stack with Image and Text
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Trivandrum on your mind?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Build, organize and maps\nout your best trip with WANDER05',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Navigate to the planning page
                                    },
                                    child: Text('Start Planning'),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Hero(
                              tag: 'trip_image',
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/tvm.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Container with Image and Text
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/tvm.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 220,
                      left: 20,
                      child: Text(
                        'Trivandrum',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 260,
                      left: 20,
                      child: Text(
                        'Where Serenity Meets Splendor',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Text widget with information
              Text(
                'Trivandrum is the capital city of Kerala, a state in southwestern India. '
                'It is known for its British colonial architecture and art galleries. '
                'The city is also home to several beaches, including Kovalam Beach, '
                'which features iconic lighthouses and crescent-shaped shorelines.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 16),
              // Row of speciality icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSpecialityIcon(Icons.beach_access, 'Beaches'),
                  _buildSpecialityIcon(Icons.local_dining, 'Cuisine'),
                  _buildSpecialityIcon(Icons.landscape, 'Nature'),
                  _buildSpecialityIcon(Icons.history, 'Culture'),
                ],
              ),
              SizedBox(height: 16),
              // Text widget for top sights
              Text(
                'Top Sights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // GridView for top sights
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildSightCard('images/tvm/tvm2.jpg', 'Sight 1', 'Short description of sight 1', 4.5),
                  _buildSightCard('images/tvm/tvm3.jpg', 'Sight 2', 'Short description of sight 2', 4.2),
                  _buildSightCard('images/tvm/tvm4.jpg', 'Sight 3', 'Short description of sight 3', 4.8),
                  _buildSightCard('images/tvm/tvm5.jpg', 'Sight 4', 'Short description of sight 4', 4.4),
                  _buildSightCard('images/tvm/tvm6.jpg', 'Sight 5', 'Short description of sight 5', 4.6),
                ],
              ),

              // Food Spots section
              SizedBox(height: 20),
              Text(
                'Food Spots',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200, // Adjust the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFoodSpotCard(
                      'images/foodspot1.jpg',
                      'Food Spot 1',
                      'Description of Food Spot 1',
                      4.5,
                    ),
                    _buildFoodSpotCard(
                      'images/foodspot1.jpg',
                      'Food Spot 2',
                      'Description of Food Spot 2',
                      4.2,
                    ),
                    _buildFoodSpotCard(
                      'images/foodspot1.jpg',
                      'Food Spot 3',
                      'Description of Food Spot 3',
                      4.8,
                    ),
                    // Add more food spots as needed
                  ],
                ),
              ),

              // Review section
              SizedBox(height: 20),
              Text(
                'Reviews Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: reviewOverview.entries.map((entry) {
                  return Column(
                    children: [
                      Text('${entry.value} ${entry.key} Stars'),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text(
                'User Reviews',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Display user reviews
              Column(
                children: userReviews.map((review) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(review.userImage),
                          radius: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rating: ${review.rating}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(review.reviewText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.blueAccent,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.grey[400],
  currentIndex: _selectedIndex,
  onTap: (index) {
    _onItemTapped(context, index);
  },
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Overview',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.hotel),
      label: 'Hotels',
    ),
  ],
),

    );
  }
  
  void setState(Null Function() param0) {}
}
  

  Widget _buildSpecialityIcon(IconData iconData, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: Icon(
            iconData,
            size: 30,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildSightCard(String imagePath, String name, String description, double rating) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodSpotCard(String imagePath, String name, String description, double rating) {
    return Card(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            child: Image.asset(
              imagePath,
              width: 150, // Set the width of the image
              height: 120, // Set the height of the image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _onItemTapped(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/overview');
      break;
    case 1:
      Navigator.pushNamed(context, '/explore');
      break;
    case 2:
      Navigator. pushNamed(context, '/hotels');
      break;
    default:
      break;
  }
}
