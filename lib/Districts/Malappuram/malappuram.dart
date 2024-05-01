import 'package:flutter/material.dart';

class MalappuramPage extends StatelessWidget {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Malappuram Beauty'),
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
                    image: AssetImage('images/malappuramcover.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Welcome to Malappuram',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Text description of Malappuram
              Text(
                'Malappuram is a district in the Indian state of Kerala. '
                'It is known for its natural beauty, religious diversity, '
                'and rich cultural heritage. Malappuram has a mix of '
                'historic sites, beautiful beaches, and lush greenery.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              // Speciality icons representing different aspects of Malappuram
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSpecialityIcon(Icons.nature, 'Nature'),
                  _buildSpecialityIcon(Icons.history, 'History'),
                  _buildSpecialityIcon(Icons.local_offer, 'Culture'),
                  _buildSpecialityIcon(Icons.local_activity, 'Religion'),
                ],
              ),
              SizedBox(height: 16),
              // Top sights in Malappuram
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
                    'images/mala1.png',
                    'Kottakkunnu',
                    'Kottakkunnu is a hill garden with an open-air theatre and a museum.',
                    4.5,
                  ),
                  _buildSightCard(
                    'images/mala2.png',
                    'Adyanpara Waterfalls',
                    'Adyanpara Waterfalls is a scenic waterfall surrounded by lush greenery.',
                    4.3,
                  ),
                  _buildSightCard(
                    'images/mala3.png',
                    'Kadalundi Bird Sanctuary',
                    'Kadalundi Bird Sanctuary is a haven for bird watchers with its diverse bird species.',
                    4.6,
                  ),
                  _buildSightCard(
                    'images/mala4.png',
                    'Keraladeshpuram Temple',
                    'Keraladeshpuram Temple is an ancient temple dedicated to Lord Vishnu.',
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
                      'images/malafs1.png',
                      'Al Madeena Restaurant',
                      'Description of Al Madeena Restaurant',
                      4.5,
                    ),
                    _buildFoodSpotCard(
                      'images/malafs2.png',
                      'Dhe Puttu',
                      'Description of Dhe Puttu',
                      4.2,
                    ),
                    _buildFoodSpotCard(
                      'images/malafs3.png',
                      'Zain\'s Hotel',
                      'Description of Zain\'s Hotel',
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
