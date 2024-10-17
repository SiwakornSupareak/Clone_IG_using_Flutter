import 'package:flutter/material.dart';
import 'dart:async';

// StoriesWidget Definition
class StoriesWidget extends StatefulWidget {
  final List<String> storyImages;
  final List<String> storyNames;

  const StoriesWidget({
    super.key,
    required this.storyImages,
    required this.storyNames,
  });

  @override
  _StoriesWidgetState createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  final ScrollController _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showStory(int index) {
    // Define a list of story images corresponding to each story
    List<List<String>> storyImagesList = [
      ['assets/images/storyimg1.jpg'], // For the first story
      ['assets/images/storyimg2.jpg'], // For the second story
      ['assets/images/storyimg3.jpg'], // For the third story
      ['assets/images/storyimg4.webp'], // For the fourth story
      ['assets/images/storyimg5.jpg'], // For the fifth story
      ['assets/images/storyimg6.jpg'], // For the sixth story
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StoryDialog(
          storyImages: storyImagesList[index], // Pass the correct images based on the index
          initialIndex: 0, // Start at the first image
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.storyImages.length == widget.storyNames.length,
        'The length of storyImages and storyNames must be the same.');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      height: 110,
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: widget.storyImages.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 100,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _showStory(index),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(255, 245, 145, 170),
                              width: 5,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(widget.storyImages[index]),
                            radius: 40,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          widget.storyNames[index],
                          style: const TextStyle(fontSize: 12.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: -9,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: _scrollLeft,
            ),
          ),
          Positioned(
            right: -9,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_right),
              onPressed: _scrollRight,
            ),
          ),
        ],
      ),
    );
  }
}

// StoryDialog Definition
class StoryDialog extends StatefulWidget {
  final List<String> storyImages;
  final int initialIndex;

  const StoryDialog({
    super.key,
    required this.storyImages,
    required this.initialIndex,
  });

  @override
  _StoryDialogState createState() => _StoryDialogState();
}

class _StoryDialogState extends State<StoryDialog> {
  late int _currentIndex;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the dialog is closed
    super.dispose();
  }

  // void _nextStory() {
  //   if (_currentIndex < widget.storyImages.length - 1) {
  //     setState(() {
  //       _currentIndex++;
  //     });
  //     _resetTimer(); // Reset the timer
  //   } else {
  //     Navigator.of(context).pop(); // Close the dialog if it's the last story
  //   }
  // }

  // void _previousStory() {
  //   if (_currentIndex > 0) {
  //     setState(() {
  //       _currentIndex--;
  //     });
  //     _resetTimer(); // Reset the timer
  //   }
  // }

  // void _resetTimer() {
  //   _timer?.cancel(); // Cancel the previous timer
  //   _startTimer(); // Start a new timer
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.storyImages.isEmpty) {
      return const Center(child: Text("No stories available", style: TextStyle(color: Colors.white)));
    }

    return Dialog(
      backgroundColor: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            widget.storyImages[_currentIndex],
            fit: BoxFit.cover,
            width: 340,
            height: 700,
          ),
          // Positioned(
          //   left: 20,
          //   top: 325,
          //   child: Container(
          //     padding: const EdgeInsets.all(3.0),
          //     decoration: BoxDecoration(
          //       color: const Color.fromARGB(128, 255, 255, 255),
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: IconButton(
          //       icon: const Icon(Icons.arrow_left, color: Colors.black),
          //       onPressed: _previousStory,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   right: 20,
          //   top: 325,
          //   child: Container(
          //     padding: const EdgeInsets.all(3.0),
          //     decoration: BoxDecoration(
          //       color: const Color.fromARGB(128, 255, 255, 255),
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //     child: IconButton(
          //       icon: const Icon(Icons.arrow_right, color: Colors.black),
          //       onPressed: _nextStory,
          //     ),
          //   ),
          // ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Color.fromARGB(255, 255, 0, 0)),
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
            ),
          ),
        ],
      ),
    );
  }
}
