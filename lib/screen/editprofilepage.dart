import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Color buttonColor;

  const EditProfilePage({super.key, this.buttonColor = Colors.blue});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with current name and username
    _nameController.text = "Siwakorn Supareak"; 
    _usernameController.text = "Stelle"; 
  }

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
          'Edit Profile',
          style: TextStyle(color: Colors.white), // Change title color to white
        ),
        backgroundColor: Colors.black, // Change background color to black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username',
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your full name',
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Profile Name',
              style: TextStyle(fontSize: 18.0),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Enter your username',
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: widget.buttonColor, // Button color
                ),
                onPressed: () {
                  // Handle save action (e.g., save the new name and username)
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'username': _usernameController.text,
                  });
                },
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
