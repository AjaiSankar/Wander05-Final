import 'package:flutter/material.dart';

class AlappuzhaPage extends StatelessWidget {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alappuzha Beauty'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image with a description
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/alappuzha_cover.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Welcome to Alappuzha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Text description of Alappuzha
              Text(
                'Alappuzha, also known as Alleppey, is a city in the state of Kerala, India. '
                'It is famous for its backwaters, houseboat cruises, beaches, and boat races. '
                'Alappuzha is often referred to as the "Venice of the East" due to its picturesque '
                'canals, lagoons, and waterways.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Speciality icons representing different aspects of Alappuzha
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
              // Top sights in Alappuzha
              Text(
                'Top Sights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildSightCard(
                    'images/alappuzha1.png',
                    'Alappuzha Beach',
                    'Alappuzha Beach is a scenic beach known for its golden sand and sunset views.',
                    4.5,
                  ),
                  _buildSightCard(
                    'images/alappuzha2.png',
                    'Alappuzha Backwaters',
                    'Alappuzha Backwaters offer enchanting boat cruises through serene waterways and lush greenery.',
                    4.3,
                  ),
                  _buildSightCard(
                    'images/alappuzha3.png',
                    'Houseboat Cruises',
                    'Houseboat cruises in Alappuzha offer a unique experience of staying and dining on traditional Kettuvallams.',
                    4.6,
                  ),
                  _buildSightCard(
                    'images/alappuzha4.png',
                    'Alappuzha Lighthouse',
                    'Alappuzha Lighthouse offers panoramic views of the city and surrounding backwaters from its top.',
                    4.4,
                  ),
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
                      'images/ala1.png',
                      'Indian Coffee House Alappuzha',
                      'Description of Indian Coffee House Alappuzha',
                      4.5,
                    ),
                    _buildFoodSpotCard(
                      'images/ala2.png',
                      'Cafe Kutch',
                      'Description of Cafe Kutch',
                      4.2,
                    ),
                    _buildFoodSpotCard(
                      'images/ala3.png',
                      'Ripples Multi Cuisine Restaurant Alappuzha',
                      'Ripples Multi Cuisine Restaurant Alappuzha',
                      4.8,
                    ),
                  ],
                ),
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
        onTap: (int index) {
          _onItemTapped(context, index);
        },
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
        Navigator.pushNamed(context, '/hotels');
        break;
      default:
        break;
    }
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

  Widget _buildSightCard(
    String imagePath,
    String name,
    String description,
    double rating,
  ) {
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

  Widget _buildFoodSpotCard(
    String imagePath,
    String name,
    String description,
    double rating,
  ) {
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
}
