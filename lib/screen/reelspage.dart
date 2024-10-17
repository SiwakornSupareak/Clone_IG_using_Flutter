import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:clone_web/screen/commentpage.dart';
import 'package:clone_web/screen/contactpage1.dart';

void main() {
  // Set the app to fullscreen mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Reels',
      theme: ThemeData.dark(),
      home: const ReelsPage(),
    );
  }
}

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late List<VideoPlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    _controllers = [
      VideoPlayerController.asset('assets/videos/firefly.mp4'),
      VideoPlayerController.asset('assets/videos/kafka.mp4'),
      VideoPlayerController.asset('assets/videos/blackswan.mp4'),
    ];

    await Future.wait(_controllers.map((controller) async {
      await controller.initialize();
      controller.setLooping(true);
      controller.setVolume(0); // Mute videos initially
      controller.play(); // Start playing the video
    })).then((_) {
      setState(() {}); // Update UI after all controllers are initialized
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reels', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(8.0),
              childAspectRatio: 9 / 16,
              children: List.generate(_controllers.length, (index) {
                return VideoReel(
                  controller: _controllers[index],
                  profileImage: _getProfileImage(index),
                  username: _getUsername(index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _getProfileImage(int index) {
    switch (index) {
      case 0:
        return 'assets/images/storyicon3.jpg';
      case 1:
        return 'assets/images/storyicon1.jpg';
      case 2:
        return 'assets/images/storyicon6.png';
      default:
        return '';
    }
  }

  String _getUsername(int index) {
    switch (index) {
      case 0:
        return 'Firefly';
      case 1:
        return 'Kafka';
      case 2:
        return 'BlackSwan';
      default:
        return '';
    }
  }
}

class VideoReel extends StatelessWidget {
  final VideoPlayerController controller;
  final String profileImage;
  final String username;

  const VideoReel({
    super.key,
    required this.controller,
    required this.profileImage,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _playFullScreen(context),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoPlayer(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playFullScreen(BuildContext context) {
    controller.setVolume(1.0);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPage(
          controller: controller,
          profileImage: profileImage,
          username: username,
        ),
      ),
    ).then((_) {
      controller.setVolume(0);
    });
  }
}

class FullScreenVideoPage extends StatefulWidget {
  final VideoPlayerController controller;
  final String profileImage;
  final String username;

  const FullScreenVideoPage({
    super.key,
    required this.controller,
    required this.profileImage,
    required this.username,
  });

  @override
  _FullScreenVideoPageState createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  bool _isFollowing = false;
  bool _isLiked = false;

  int _likeCount = 10; // Initialize like count
  int _commentCount = 5; // Initialize comment count

  @override
  void initState() {
    super.initState();
    widget.controller.play();
    _enterFullscreen();
    widget.controller.addListener(() {
      if (widget.controller.value.hasError) {
        // Handle error if needed
      }
    });
  }

  @override
  void dispose() {
    _exitFullscreen();
    super.dispose();
  }

  void _enterFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  void _exitFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1; // Increment or decrement like count
    });
  }

  void _handleComment() {
    setState(() {
      _commentCount++; // Increment comment count
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommentsPage()),
    );
  }

  void _handleShare() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactPage1()),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Add to favorites', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('About this account', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Save', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Report', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
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
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: _toggleLike,
        child: Center(
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 9 / 16,
                child: VideoPlayer(widget.controller),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        widget.profileImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: _toggleFollow,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(color: Colors.black, width: 1.5),
                                ),
                              ),
                              child: Text(
                                _isFollowing ? 'Following' : 'Follow',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          _exitFullscreen(); // Maintain immersive mode
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 16,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _toggleLike,
                      child: Column(
                        children: [
                          Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_border,
                            color: _isLiked ? Colors.red : Colors.white,
                          ),
                          Text(
                            '$_likeCount',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12), // Space between like and comment icons
                    GestureDetector(
                      onTap: _handleComment,
                      child: Column(
                        children: [
                          const Icon(Icons.comment, color: Colors.white),
                          Text(
                            '$_commentCount',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 0), // Space between comment and share icons
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: _handleShare,
                    ),
                    const SizedBox(height: 0), // Space between share and more options icons
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () => _showMoreOptions(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
