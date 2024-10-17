import 'package:clone_web/screen/home_screen.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Start the timer when the loading page is initialized
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InstagramHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // or your desired background color
      body: Center(
        child: Image.asset(
          'assets/images/ig.png', // Make sure to add the logo in your assets
          width: 150, // Adjust width as needed
          height: 150, // Adjust height as needed
        ),
      ),
    );
  }
}
