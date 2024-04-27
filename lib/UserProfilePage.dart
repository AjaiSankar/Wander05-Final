import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _interestController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Function to fetch user data
  void _fetchUserData() async {
    // Fetch user data from Firestore
  }

  // Function to update user profile information
  void _updateUserProfile() async {
    // Update user profile in Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing; // Toggle editing mode
              });
            },
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Profile picture
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(
                _auth.currentUser?.photoURL ??
                    'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
              ),
            ),
            SizedBox(height: 20),
            // Name, Place, Email, Phone
            Text(
              _auth.currentUser?.displayName ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _auth.currentUser?.email ?? 'No Email',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Place: Your place',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: Your phone number',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Travel Interests
            _isEditing
                ? TextFormField(
                    controller: _interestController,
                    decoration: InputDecoration(labelText: 'Add Interests'),
                  )
                : Text(
                    'Interests: Your interests',
                    style: TextStyle(fontSize: 18),
                  ),
            SizedBox(height: 20),
            // Pictures of visited places
            Text(
              'Pictures of Visited Places',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Display pictures of visited places (to be implemented)
            SizedBox(height: 20),
            // Plans created on the app
            Text(
              'Plans Created',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // Display plans created on the app (to be implemented)
          ],
        ),
      ),
    );
  }
}
