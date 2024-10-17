import 'package:flutter/material.dart';

class ShareProfilePage extends StatelessWidget {
  const ShareProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Change back icon color to white
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text(
          'Share Profile',
          style: TextStyle(color: Colors.white), // Change title color to white
        ),
        backgroundColor: Colors.black, // Change background color to black
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the image
            Image.asset(
              'assets/images/qr.jpg', // Update with your asset path
              width: 800, // Set the width of the image
              height: 600, // Set the height of the image
            ),
            // const SizedBox(height: 20.0),
            // const Text(
            //   'Share your profile here!',
            //   style: TextStyle(fontSize: 24.0),
            // ),
          ],
        ),
      ),
    );
  }
}
