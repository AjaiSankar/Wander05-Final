import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late VideoPlayerController _controller;
  late String _currentQuote;
  int _quoteIndex = 0;

  List<String> _quotes = [
    "",
    "",
    // Add more quotes as needed
  ];

  late Timer _quoteTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('videos/main.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
    _currentQuote = _getRandomQuote();
    _startQuoteTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _quoteTimer.cancel();
  }

  String _getRandomQuote() {
    return _quotes[_quoteIndex];
  }

  void _startQuoteTimer() {
    const quoteDuration = Duration(seconds: 5); // Adjust quote display duration as needed
    _quoteTimer = Timer.periodic(quoteDuration, (Timer timer) {
      setState(() {
        _quoteIndex = (_quoteIndex + 1) % _quotes.length;
        _currentQuote = _getRandomQuote();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Background color
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              color: Colors.black.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: 1.0,
                    child: Text(
                      _currentQuote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Add space between text and button
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press if needed
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      minimumSize: Size(double.infinity, 0), // full width
                    ),
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
