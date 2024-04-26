import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _locationController;
  late TextEditingController _interestsController;
  late File? _image;
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _locationController = TextEditingController();
    _interestsController = TextEditingController();
    _userId = _firebaseAuth.currentUser!.uid;

    // Fetch user details if available
    _fetchUserDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _locationController.dispose();
    _interestsController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserDetails() async {
    final userData = await _firestore.collection('users').doc(_userId).get();
    if (userData.exists) {
      final data = userData.data() as Map<String, dynamic>;
      _nameController.text = data['name'] ?? '';
      _usernameController.text = data['username'] ?? '';
      _locationController.text = data['location'] ?? '';
      _interestsController.text = data['interests'] ?? '';
    }
  }

  Future<void> _saveDetails() async {
    try {
      await _firestore.collection('users').doc(_userId).set({
        'name': _nameController.text,
        'username': _usernameController.text,
        'location': _locationController.text,
        'interests': _interestsController.text,
      });
      // Optionally, upload the profile photo to Firebase Storage and save the URL in Firestore
    } catch (e) {
      print('Failed to save details: $e');
    }
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_image != null) ...[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(_image!),
                ),
                SizedBox(height: 10),
              ],
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Select Profile Photo'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _interestsController,
                decoration: InputDecoration(labelText: 'Travel Interests'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your travel interests';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveDetails();
                  }
                },
                child: Text('Save Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
