import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: const [
          // Sample notifications
          NotificationItem(
            userName: 'Kafka',
            message: 'started following you.',
            time: '2m ago',
            profileImageUrl: 'assets/images/storyicon1.jpg',
          ),
          NotificationItem(
            userName: 'Kafka',
            message: 'liked your photo.',
            time: '2m ago',
            profileImageUrl: 'assets/images/storyicon1.jpg',
          ),
          NotificationItem(
            userName: 'SilverWolf',
            message: 'started following you',
            time: '5m ago',
            profileImageUrl: 'assets/images/storyicon2.jpg',
          ),
          NotificationItem(
            userName: 'SilverWolf',
            message: 'liked your photo',
            time: '5m ago',
            profileImageUrl: 'assets/images/storyicon2.jpg',
          ),
           NotificationItem(
            userName: 'Firefly',
            message: 'liked your photo',
            time: '8m ago',
            profileImageUrl: 'assets/images/storyicon3.jpg',
          ),
          NotificationItem(
            userName: 'Firefly',
            message: 'liked your photo',
            time: '8m ago',
            profileImageUrl: 'assets/images/storyicon3.jpg',
          ),
          NotificationItem(
            userName: 'Acheron',
            message: 'liked your photo',
            time: '10m ago',
            profileImageUrl: 'assets/images/storyicon4.png',
          ),
          NotificationItem(
            userName: 'BlackSwan',
            message: 'liked your photo',
            time: '10m ago',
            profileImageUrl: 'assets/images/storyicon6.png',
          ),
          NotificationItem(
            userName: 'Bronya',
            message: 'liked your photo',
            time: '12m ago',
            profileImageUrl: 'assets/images/storyicon5.webp',
          ),
          NotificationItem(
            userName: 'March 7th',
            message: 'liked your photo',
            time: '14m ago',
            profileImageUrl: 'assets/images/march.jpg',
          ),
          NotificationItem(
            userName: 'Ruan Mei',
            message: 'liked your photo',
            time: '15m ago',
            profileImageUrl: 'assets/images/ruanmei.jpg',
          ),
          NotificationItem(
            userName: 'Himeko',
            message: 'liked your photo',
            time: '15m ago',
            profileImageUrl: 'assets/images/himeko.jpg',
          ),
          NotificationItem(
            userName: 'Sushang',
            message: 'liked your photo',
            time: '17m ago',
            profileImageUrl: 'assets/images/sushang.jpg',
          ),
          NotificationItem(
            userName: 'Guinaifen',
            message: 'liked your photo',
            time: '20m ago',
            profileImageUrl: 'assets/images/guinaifen.png',
          ),
          // Add more NotificationItems as needed
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String userName;
  final String message;
  final String time;
  final String profileImageUrl;

  const NotificationItem({
    Key? key,
    required this.userName,
    required this.message,
    required this.time,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Profile image
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(profileImageUrl),
            onBackgroundImageError: (error, stackTrace) {
              // Handle image loading error
              print('Error loading image: $error');
            },
          ),
          const SizedBox(width: 10),
          // Notification text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$userName ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: message,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
