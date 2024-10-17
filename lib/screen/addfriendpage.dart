import 'package:flutter/material.dart';

class RecIconsPage extends StatefulWidget {
  const RecIconsPage({super.key});

  @override
  _RecIconsPageState createState() => _RecIconsPageState();
}

class _RecIconsPageState extends State<RecIconsPage> {
  final List<String> storyImages = [
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

  final List<String> storyNames = [
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

  // List to track follow state
  late List<bool> isFollowed;

  @override
  void initState() {
    super.initState();
    isFollowed = List<bool>.filled(storyImages.length, false); // Initialize all as unfollowed
  }

  void toggleFollow(int index) {
    setState(() {
      isFollowed[index] = !isFollowed[index]; // Toggle follow state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friends'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = (constraints.maxWidth / 180).floor();

          return SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(15.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: storyImages.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2.0),
                              ),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(storyImages[index]),
                                radius: 50.0,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              storyNames[index],
                              style: const TextStyle(fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5.0),
                            SizedBox(
                              width: 110.0,
                              height: 34.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  toggleFollow(index); // Toggle follow state
                                }, // Change button text
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                ),
                                child: Text(isFollowed[index] ? 'Following' : 'Follow'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
