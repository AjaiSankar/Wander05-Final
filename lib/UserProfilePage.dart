import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _userName = 'Name';
  String _location = 'Location';
  String _about = 'About the user';

  List<Map<String, dynamic>> _userDisasters = [];

  @override
  void initState() {
    super.initState();
    fetchUserDisasters();
  }

void fetchUserDisasters() async {
  final user = _auth.currentUser;
  if (user != null) {
    final userId = user.uid;
    final querySnapshot = await _firestore.collection('disaster_reports').get();

    List<Map<String, dynamic>> userDisasters = [];
    querySnapshot.docs.forEach((districtDoc) {
      final districtData = districtDoc.data();
      final district = districtData['name']; // Assuming district name is stored in a field named 'name'
      final disasters = districtData.keys.where((key) => key != 'name').toList();

      disasters.forEach((disasterType) async {
        final disasterSnapshot = await districtDoc.reference.collection(disasterType).where('userId', isEqualTo: userId).get();
        
        disasterSnapshot.docs.forEach((userDoc) {
          final userData = userDoc.data();
          final severity = userData['severity'];
          final timestamp = userData['timestamp'];
          final email = userData['email'];
          userDisasters.add({
            'district': district,
            'disasterType': disasterType,
            'severity': severity,
            'timestamp': timestamp,
            'email': email,
          });
        });
      });
    });

    print('User Disasters: $userDisasters');

    setState(() {
      _userDisasters = userDisasters;
    });
  }
}






  void _editDetails() async {
    // Implementation remains the same
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editDetails,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileInfo(),
            _buildUserDisasters(),
            _buildInterests(),
            _buildUploadedPics(),
            _buildReviews(),
            _buildVisitedPlaces(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    // Implementation remains the same
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('images/user1.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            _userName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            _location,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            _about,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

 Widget _buildUserDisasters() {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reported Disasters',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _userDisasters.isEmpty
            ? Text(
                'No disasters reported yet.',
                style: TextStyle(fontSize: 16),
              )
            : Column(
                children: _userDisasters.map((disaster) {
                  final disasterType = disaster['disasterType'] ?? 'Unknown';
                  final district = disaster['district'] ?? 'Unknown';
                  final severity = disaster['severity'] ?? 'Unknown';

                  return Card(
                    child: ListTile(
                      title: Text(disasterType),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('District: $district'),
                          Text('Severity: $severity'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ],
    ),
  );
}

  Widget _buildInterests() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'List of user interests here...',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedPics() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Uploaded Pictures',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Display uploaded pics and button to upload new ones
          // Implementation required
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Display user reviews and option to add new ones
          // Implementation required
        ],
      ),
    );
  }

  Widget _buildVisitedPlaces() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visited Places',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Display places user had visited recently along with images
          // Implementation required
        ],
      ),
    );
  }
}
