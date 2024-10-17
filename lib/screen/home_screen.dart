import 'package:clone_web/screen/notipage.dart';
import 'package:clone_web/screen/addfriendpage.dart';
import 'package:clone_web/screen/reelspage.dart';
import 'package:clone_web/screen/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:clone_web/screen/contactpage.dart';
import 'package:clone_web/screen/explorepage.dart';
import 'package:clone_web/component/postcard.dart';
import 'package:clone_web/component/storyicon.dart';
import 'package:clone_web/screen/myprofile.dart';

class InstagramHomePage extends StatefulWidget {
  const InstagramHomePage({super.key});

  @override
  _InstagramHomePageState createState() => _InstagramHomePageState();
}

class _InstagramHomePageState extends State<InstagramHomePage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    SearchPage(), // Ensure you define this widget
    const ExplorePage(),
    const ReelsPage(),
    ContactPage(),
    const NotificationsPage(),
    const UploadPage(),
  ];

  final List<String> postImages = [
    'assets/images/post1.jpg',
    'assets/images/post2.webp',
    'assets/images/post3.png',
    'assets/images/post4.jpg',
    'assets/images/post5.jpg',
    'assets/images/post6.png',
  ];

  final List<String> backgroundImages = [
    'assets/images/background1.jpg',
    'assets/images/background2.jpg',
    'assets/images/background3.jpg',
    'assets/images/background4.png',
    'assets/images/background5.webp',
    'assets/images/background6.png',
  ];

  final List<String> usernames = [
    'Kafka',
    'SilverWolf',
    'FireFly',
    'Acheron',
    'Bronya',
    'BlackSwan',
  ];

  final List<String> locations = [
    'Bangkok, Thailand',
    'Bangkok, Thailand',
    'Bangkok, Thailand',
    'Bangkok, Thailand',
    'Bangkok, Thailand',
    'Bangkok, Thailand',
  ];

  final List<String> storyImages = [
    'assets/images/storyicon1.jpg',
    'assets/images/storyicon2.jpg',
    'assets/images/storyicon3.jpg',
    'assets/images/storyicon4.png',
    'assets/images/storyicon5.webp',
    'assets/images/storyicon6.png',
  ];

  final List<String> storyNames = [
    'Kafka',
    'Silverwolf',
    'Firefly',
    'Acheron',
    'Bronya',
    'BlackSwan',
  ];

  void _showUploadInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Upload here',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 30.0),
              Image.asset(
                'assets/images/Doc.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20.0,
                width: 350,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/ig.png', fit: BoxFit.cover),
        ),
        actions: [
          IconButton(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/stelle.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfile()),
              );
            },
          ),
        ],
      ),
      body: currentIndex == 0 ? _buildHome() : pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.video_library), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.6),
        onTap: (index) {
          setState(() {
            if (index == 6) {
              _showUploadInfo(context);
            } else {
              currentIndex = index; // Change the current index to navigate
            }
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecIconsPage()),
          );
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add_alt),
      ),
    );
  }

  Widget _buildHome() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 500,
                child: StoriesWidget(
                  storyImages: storyImages,
                  storyNames: storyNames,
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: postImages.length,
            itemBuilder: (context, index) {
              final postImage = postImages[index];
              final backgroundImage =
                  backgroundImages[index % backgroundImages.length];
              final username = usernames[index % usernames.length];
              final location = locations[index % locations.length];
              final caption = 'Caption for post ${index + 1} goes here.'; // Unique caption

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0).copyWith(bottom: 16.0),
                child: SizedBox(
                  width: 500,
                  child: PostCard(
                    postImage: postImage,
                    backgroundImage: backgroundImage,
                    username: username,
                    location: location,
                    caption: caption,
                    time: '${(index + 1) * 5} minutes ago', // Start from 5 minutes ago
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Placeholder for HomeScreen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Screen'));
  }
}

// Placeholder for UploadPage
class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Upload Page'));
  }
}
