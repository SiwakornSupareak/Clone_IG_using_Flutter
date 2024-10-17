import 'package:clone_web/component/postcard2.dart'; // Adjust import based on your structure
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3, // Adjust for 3 columns
          childAspectRatio: 1, // Aspect ratio of the grid items
          children: List.generate(
            3, // Number of posts
            (index) => _buildPostCard(
              context,
              'assets/images/${index == 0 ? 'feixiao_post' : index == 1 ? 'ruanmei_post' : 'himeko_post'}.jpg',
              'assets/images/${index == 0 ? 'feixiao' : index == 1 ? 'ruanmei' : 'himeko'}.jpg',
              index == 0 ? 'Feixiao' : index == 1 ? 'Ruan Mei' : 'Himeko',
              'Bangkok, Thailand',
              index == 0 ? 'Feixiao: Hey there!' : index == 1 ? 'Ruan Mei: Hello...' : 'Himeko: Nice to meet you.',
              '${(index + 1) * 5} minutes ago', // Start from 5 minutes ago
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, String postImage, String backgroundImage, String username, String location, String caption, String time) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostCard2(
              postImage: postImage,
              backgroundImage: backgroundImage,
              username: username,
              location: location,
              caption: caption,
              time: time, // Pass the timestamp here
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            postImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
