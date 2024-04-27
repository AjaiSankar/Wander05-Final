import 'package:flutter/material.dart';

class ThrissurPage extends StatelessWidget {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thrissur Beauty'),
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
                    image: AssetImage('images/thrissurcover.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Welcome to Thrissur',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Text description of Thrissur
              Text(
                'Thrissur is a city in the Indian state of Kerala. '
                'It is known as the Cultural Capital of Kerala '
                'due to its rich cultural heritage and historical importance. '
                'Thrissur is famous for its festivals, art, and traditional architecture.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Speciality icons representing different aspects of Thrissur
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSpecialityIcon(Icons.music_note, 'Festivals'),
                  _buildSpecialityIcon(Icons.art_track, 'Art'),
                  _buildSpecialityIcon(Icons.architecture, 'Architecture'),
                  _buildSpecialityIcon(Icons.history, 'History'),
                ],
              ),
              SizedBox(height: 16),
              // Top sights in Thrissur
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
                    'images/thh1.png',
                    'Vadakkunnathan Temple',
                    'Vadakkunnathan Temple is an ancient Hindu temple dedicated to Lord Shiva, '
                        'known for its magnificent architecture and religious significance.',
                    4.5,
                  ),
                  _buildSightCard(
                    'images/th2.png',
                    'Thrissur Pooram',
                    'Thrissur Pooram is the most famous temple festival in Kerala, known for its '
                        'spectacular processions, elephant pageantry, and traditional percussion performances.',
                    4.8,
                  ),
                  _buildSightCard(
                    'images/th3.png',
                    'Shakthan Thampuran Palace',
                    'Shakthan Thampuran Palace is a cultural heritage monument in Thrissur, '
                        'known for its architectural beauty and historical significance.',
                    4.3,
                  ),
                  _buildSightCard(
                    'images/th4.png',
                    'Athirappilly Waterfalls',
                    'Athirappilly Waterfalls is the largest waterfall in Kerala, located in the '
                        'western Ghats amidst lush green forests, a popular tourist destination.',
                    4.6,
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
                      'images/trifood1.png',
                      'Thalappakatti Restaurant',
                      'Description of Thalappakatti Restaurant',
                      4.5,
                    ),
                    _buildFoodSpotCard(
                      'images/trifood2.png',
                      'Hotel Bharath',
                      'Description of Hotel Bharath',
                      4.2,
                    ),
                    _buildFoodSpotCard(
                      'images/trifood3.png',
                      'Marrybrown',
                      'Description of Marrybrown',
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
