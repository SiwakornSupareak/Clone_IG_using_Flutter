import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String postImage;
  final String backgroundImage;
  final String username;
  final String location;
  final String caption;
  final String time;

  const PostCard({
    required this.postImage,
    required this.backgroundImage,
    required this.username,
    required this.location,
    required this.caption,
    required this.time,
    super.key,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;
  bool _isBookmarked = false;
  int favoritesCount = 10;
  int _commentCount = 5;

  void _onLocationTap() {
    // Add your location page navigation logic here
  }

  void _onShareTap() {
    // Add your share page navigation logic here
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'edit':
        print('Edit tapped');
        break;
      case 'report':
        print('Report tapped');
        break;
      case 'save':
        print('Save tapped');
        break;
      case 'delete':
        print('Delete tapped');
        break;
      default:
        print('Unknown action');
        break;
    }
  }

  void _handleComment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsPage(
          onCommentSent: () {
            setState(() {
              _commentCount++; // Increment comment count
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(),
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                _isLiked = !_isLiked;
                if (_isLiked) favoritesCount++;
                else favoritesCount--;
              });
            },
            child: _buildPostImage(),
          ),
          _buildActions(),
          _buildLikes(),
          _buildCaption(),
          _buildViewComments(),
          _buildTimestamp(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.backgroundImage),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.username),
                  InkWell(
                    onTap: _onLocationTap,
                    child: Text(
                      widget.location,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: _onMenuItemSelected,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'favorites',
                child: Text('Add to favorites'),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('About this account'),
              ),
              const PopupMenuItem<String>(
                value: 'save',
                child: Text('Save'),
              ),
              const PopupMenuItem<String>(
                value: 'report',
                child: Text('Report'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Image.asset(
          widget.postImage,
          fit: BoxFit.cover,
          height: 500,
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _isLiked = !_isLiked;
                if (_isLiked) favoritesCount++;
                else favoritesCount--;
              });
            },
            child: Row(
              children: [
                Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.black,
                ),
                const SizedBox(width: 5),
                Text(
                  favoritesCount.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: _handleComment,
            child: Row(
              children: [
                const Icon(Icons.comment_outlined),
                const SizedBox(width: 5),
                Text(
                  _commentCount.toString(),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: _onShareTap,
            child: const Icon(Icons.send),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
            child: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikes() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Text('Liked by user1, user2 and others'),
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Text(widget.caption),
    );
  }

  Widget _buildViewComments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Text('View all $_commentCount comments...'),
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Text(
        widget.time,
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class CommentsPage extends StatefulWidget {
  final VoidCallback onCommentSent;

  const CommentsPage({required this.onCommentSent, Key? key}) : super(key: key);

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
      'extraText': '2 hours ago'
    },
    {
      'username': 'Serval',
      'comment': 'Amazing picture!',
      'avatar': 'assets/images/serval.jpg',
      'replies': [],
      'extraText': '1 hour ago'
    },
    {
      'username': 'March 7th',
      'comment': 'So beautiful!',
      'avatar': 'assets/images/march.jpg',
      'replies': [],
      'extraText': '30 minutes ago'
    },
    {
      'username': 'Sushang',
      'comment': 'Great shot!',
      'avatar': 'assets/images/sushang.jpg',
      'replies': [],
      'extraText': '15 minutes ago'
    },
    {
      'username': 'Guinaifen',
      'comment': 'Incredible!',
      'avatar': 'assets/images/guinaifen.png',
      'replies': [],
      'extraText': 'Just now'
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
          'extraText': 'Just now'
        });
        widget.onCommentSent(); // Notify the parent widget
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
          'extraText': 'Just now'
        });
        widget.onCommentSent(); // Notify the parent widget
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
                    opacity: 0.5,
                    child: Text(
                      comment['extraText']!,
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
                          opacity: 0.5,
                          child: Text(
                            reply['extraText']!,
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
