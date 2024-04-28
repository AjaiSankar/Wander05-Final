import 'package:flutter/material.dart';

class ErnakulamPage extends StatelessWidget {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ernakulam Beauty'),
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
                    image: AssetImage('images/ernakulamcover.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Welcome to Ernakulam',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Text description of Ernakulam
              Text(
                'Ernakulam is a district in the Indian state of Kerala. '
                'It is known for its vibrant culture, historical significance, '
                'and economic importance. Ernakulam is also famous for its '
                'backwaters, beaches, and religious landmarks.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Speciality icons representing different aspects of Ernakulam
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSpecialityIcon(Icons.beach_access, 'Beaches'),
                  _buildSpecialityIcon(Icons.local_library, 'Culture'),
                  _buildSpecialityIcon(Icons.local_hospital, 'Healthcare'),
                  _buildSpecialityIcon(Icons.local_attraction, 'Attractions'),
                ],
              ),
              SizedBox(height: 16),
              // Top sights in Ernakulam
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
                    'images/fortkochi.png',
                    'Fort Kochi',
                    'Fort Kochi is a historic neighborhood known for its colonial architecture',
                    4.5,
                  ),
                  _buildSightCard(
                    'images/mattachery.png',
                    'Mattancherry Palace',
                    'Mattancherry Palace, also known as the Dutch Palace, is a Portuguese palace known for its Kerala murals from the royal family.',
                    4.3,
                  ),
                  _buildSightCard(
                    'images/cherari.png',
                    'Cherai Beach',
                    'Cherai Beach famous for its serene beauty and golden sands.',
                    4.6,
                  ),
                  _buildSightCard(
                    'images/hillpalace.png',
                    'Hill Palace',
                    'Hill Palace is the largest archaeological museum in Kerala, belonging to the Maharaja of Kochi.',
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
                      'images/er1.png',
                      'Kochi Kitchen',
                      'Description of Kochi Kitchen',
                      4.5,
                    ),
                    _buildFoodSpotCard(
                      'images/er2.png',
                      'Fort House Restaurant',
                      'Description of Fort House Restaurant',
                      4.2,
                    ),
                    _buildFoodSpotCard(
                      'images/er3.png',
                      'Rice Boat Restaurant',
                      'Description of Rice Boat Restaurant',
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
