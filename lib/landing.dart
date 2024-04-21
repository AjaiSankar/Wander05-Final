import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildVideoSlide(videoPath: 'videos/land1.mp4'),
              _buildVideoSlide(videoPath: 'videos/land1.mp4'),
              _buildLastSlide(context),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSlide({required String videoPath}) {
    final VideoPlayerController _controller = VideoPlayerController.asset(videoPath);
    _controller.initialize().then((_) {
      _controller.play();
      setState(() {});
    });

    return VideoPlayer(_controller);
  }

  Widget _buildLastSlide(BuildContext context) {
    return Container(
      color: Colors.teal, // Change color or add decoration as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ready to Start Your Journey?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to login page
            },
            child: Text('Login'),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Continue as guest action
            },
            child: Text(
              'Continue as Guest',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
