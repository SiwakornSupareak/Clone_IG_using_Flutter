import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final List<Map<String, dynamic>> comments = [
    {
      'username': 'Seele',
      'comment': 'Love this post!',
      'avatar': 'assets/images/seele.jpg',
      'replies': [],
      'extraText': '2 hours ago' // Example additional text
    },
    {
      'username': 'Serval',
      'comment': 'Amazing picture!',
      'avatar': 'assets/images/serval.jpg',
      'replies': [],
      'extraText': '1 hour ago' // Example additional text
    },
    {
      'username': 'March 7th',
      'comment': 'So beautiful!',
      'avatar': 'assets/images/march.jpg',
      'replies': [],
      'extraText': '30 minutes ago' // Example additional text
    },
    {
      'username': 'Sushang',
      'comment': 'Great shot!',
      'avatar': 'assets/images/sushang.jpg',
      'replies': [],
      'extraText': '15 minutes ago' // Example additional text
    },
    {
      'username': 'Guinaifen',
      'comment': 'Incredible!',
      'avatar': 'assets/images/guinaifen.png',
      'replies': [],
      'extraText': 'Just now' // Example additional text
    },
  ];

  final TextEditingController _commentController = TextEditingController();
  int? _replyingToIndex;

  void _addComment(String commentText) {
    if (commentText.isNotEmpty) {
      setState(() {
        comments.add({
          'username': 'Stelle',
          'comment': commentText,
          'avatar': 'assets/images/stelle.webp',
          'replies': [],
          'extraText': 'Just now' // Example additional text
        });
        _commentController.clear();
      });
    }
  }

  void _addReply(String replyText) {
    if (replyText.isNotEmpty && _replyingToIndex != null) {
      setState(() {
        comments[_replyingToIndex!]['replies'].add({
          'username': 'Stelle',
          'comment': replyText,
          'avatar': 'assets/images/stelle.webp',
          'extraText': 'Just now' // Example additional text
        });
        _commentController.clear();
        _replyingToIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return _buildCommentTile(comments[index], index);
              },
            ),
          ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentTile(Map<String, dynamic> comment, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          leading: SizedBox(
            width: 60,
            height: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage(comment['avatar']!),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    comment['username']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Opacity(
                    opacity: 0.5, // Set opacity here
                    child: Text(
                      comment['extraText']!, // Additional text
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Expanded(child: Text(comment['comment']!)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _replyingToIndex = index;
                      });
                      _commentController.text = 'Replying to ${comment['username']}...';
                    },
                    child: const Text('Reply'),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (comment['replies'].isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 70.0),
            child: Column(
              children: comment['replies'].map<Widget>((reply) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(reply['avatar']!),
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reply['username']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Opacity(
                          opacity: 0.5, // Set opacity for reply
                          child: Text(
                            reply['extraText']!, // Additional text for reply
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(reply['comment']!),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: _replyingToIndex != null ? 'Reply...' : 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_replyingToIndex != null) {
                _addReply(_commentController.text);
              } else {
                _addComment(_commentController.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
