import 'package:clone_web/screen/editprofilepage.dart';
import 'package:clone_web/screen/shareprofilepage.dart';
import 'package:flutter/material.dart';
import 'package:clone_web/screen/settingpage.dart';
import 'package:clone_web/component/postcard1.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String _name = "Siwakorn Supareak";
  String _username = "Stelle";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0), // Default height
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white), // Change icon color to white
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
            ),
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white), // Change title color to white
            ),
            backgroundColor: Colors.black, // Change background color to black
            actions: [
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white), // Change icon color to white
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Profile Avatar
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 195, 215),
                      width: 4.0,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 70.0,
                    backgroundImage: AssetImage('assets/images/stelle.webp'),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Profile Name
              Center(
                child: Text(
                  _username, // Display the updated username
                  style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  _name, // Display the updated full name
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16.0),
              // Statistics
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatColumn('Posts', '1'),
                    const SizedBox(width: 75),
                    _buildStatColumn('Following', '6'),
                    const SizedBox(width: 55),
                    _buildStatColumn('Followers', '40'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // Edit Profile and Share Profile Buttons
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate to the edit profile page
                        final updatedData = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfilePage()),
                        );

                        // Update the name and username displayed in the profile if not null
                        if (updatedData != null && updatedData is Map) {
                          setState(() {
                            _name = updatedData['name'];
                            _username = updatedData['username'];
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                    const SizedBox(width: 16.0), // Space between buttons
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the ShareProfilePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShareProfilePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      child: const Text('Share Profile'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // Posts Section
              const Text(
                'Posts',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1,
                children: [
                  // Optionally add other posts here
                  _buildPostImage(context, 'assets/images/stellepost.png', 'assets/images/stelle.webp', 'Stelle', 'Stelle: Morning...'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(width: 40.0),
      ],
    );
  }

  Widget _buildPostImage(BuildContext context, String imagePath, String backgroundImage, String username, String caption) {
    return GestureDetector(
      onTap: () {
        // Navigate to PostCard when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostCard1(
              postImage: imagePath,
              backgroundImage: backgroundImage,
              username: username,
              location: 'Bangkok, Thailand',
              caption: caption, timestamp: '1 hour ago',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
