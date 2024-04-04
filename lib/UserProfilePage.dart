import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _userName = 'Name';
  String _location = 'Location';
  String _about = 'About the user';

  void _editDetails() async {
    String newName = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Location'),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'About'),
              onChanged: (value) {
                setState(() {
                  _about = value;
                });
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_userName);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );

    if (newName != null) {
      setState(() {
        _userName = newName;
      });
    }
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
