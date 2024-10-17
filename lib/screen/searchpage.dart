import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  // Usernames List
  final List<String> _usernames = [
    'Kafka',
    'SilverWolf',
    'Firefly',
    'Acheron',
    'Bronya',
    'BlackSwan',
    'Feixiao',
    'Himeko',
    'Topaz',
    'Jade',
    'Seele',
    'Ruan Mei',
    'Sushang',
    'Guinaifen',
    'March 7th',
    'Serval',
  ];

  // Corresponding User Images List
  final List<String> _userImages = [
    'assets/images/storyicon1.jpg',
    'assets/images/storyicon2.jpg',
    'assets/images/storyicon3.jpg',
    'assets/images/storyicon4.png',
    'assets/images/storyicon5.webp',
    'assets/images/storyicon6.png',
    'assets/images/feixiao.jpg',
    'assets/images/himeko.jpg',
    'assets/images/topaz.jpg',
    'assets/images/jade.png',
    'assets/images/seele.jpg',
    'assets/images/ruanmei.jpg',
    'assets/images/sushang.jpg',
    'assets/images/guinaifen.png',
    'assets/images/march.jpg',
    'assets/images/serval.jpg',
  ];

  List<String> _filteredUsernames = [];

  @override
  void initState() {
    super.initState();
    _filteredUsernames = _usernames;
  }

  void _filterUsernames(String query) {
    final filteredUsernames = _usernames.where((username) {
      return username.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Sort to prioritize names that start with the query
    filteredUsernames.sort((a, b) {
      final aStartsWith = a.toLowerCase().startsWith(query.toLowerCase());
      final bStartsWith = b.toLowerCase().startsWith(query.toLowerCase());
      if (aStartsWith && !bStartsWith) {
        return -1; // a comes before b
      } else if (!aStartsWith && bStartsWith) {
        return 1; // b comes before a
      }
      return a.compareTo(b); // Otherwise, sort alphabetically
    });

    setState(() {
      _filteredUsernames = filteredUsernames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Search Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside of the TextField
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search User',
                  border: OutlineInputBorder(),
                ),
                onChanged: _filterUsernames,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _searchController.text.isEmpty
                    ? const Center(child: Text('Type a username to search.'))
                    : ListView.builder(
                        itemCount: _filteredUsernames.length,
                        itemBuilder: (context, index) {
                          final originalIndex = _usernames.indexOf(_filteredUsernames[index]);

                          String imagePath;
                          if (originalIndex >= 0 && originalIndex < _userImages.length) {
                            imagePath = _userImages[originalIndex];
                          } else {
                            imagePath = 'assets/images/default_image.png'; // Use a default image
                          }

                          return _buildUserProfile(imagePath, _filteredUsernames[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(String imagePath, String username) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 10),
          Text(username, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
