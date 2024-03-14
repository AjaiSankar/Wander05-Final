import 'package:flutter/material.dart';

class ExploreTrivandrumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Trivandrum'),
      ),
      body: ListView.builder(
        itemCount: spots.length,
        itemBuilder: (context, index) {
          return _buildSpotCard(context, spots[index]);
        },
      ),
    );
  }

  Widget _buildSpotCard(BuildContext context, Spot spot) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: 120.0,
            height: 160.0, // Adjust the height as needed
            child: Image.asset(
              spot.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          spot.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star_half, color: Colors.yellow),
                Icon(Icons.star_border, color: Colors.yellow),
                SizedBox(width: 8.0),
                Text('4.5 (500 reviews)'),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'Top Reviews:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text('1. ${spot.reviews[0]}'),
            Text('2. ${spot.reviews[1]}'),
          ],
        ),
        onTap: () {
          // Handle tap on spot (if needed)
        },
      ),
    );
  }
}

class Spot {
  final String name;
  final String image;
  final List<String> reviews;

  Spot({required this.name, required this.image, required this.reviews});
}

List<Spot> spots = [
  Spot(
    name: 'Kovalam Beach',
    image: 'images/main2.jpg',
    reviews: [
      'Beautiful beach with golden sand.',
      'Great place to relax and enjoy the sunset.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  Spot(
    name: 'Napier Museum',
    image: 'assets/napier_museum.jpg',
    reviews: [
      'Amazing collection of artifacts and paintings.',
      'Well-maintained museum with interesting exhibits.'
    ],
  ),
  // Add more spots as needed
];

void main() {
  runApp(MaterialApp(
    home: ExploreTrivandrumPage(),
  ));
}
