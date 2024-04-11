import 'package:flutter/material.dart';
import 'package:wander05_final/auth.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ Colors.teal, Colors.white ], // Change the colors as needed
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo widget centered above the text fields
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.asset(
                      'images/logo1.png', // Replace with your logo image path
                      height: 100, // Adjust the height as needed
                    ),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      icon: Icon(Icons.person, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.lock, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      icon: Icon(Icons.lock, color: Colors.white),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Auth authHandler = Auth();
                      // Implement your user registration logic here
                      authHandler.handleSignUp(_emailController.text, _passwordController.text)
                      .then((user) {
                            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      }).catchError((e) => print(e));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Set the button color to teal
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}