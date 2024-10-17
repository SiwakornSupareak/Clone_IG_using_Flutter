import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemChrome
import 'package:clone_web/screen/loading_screen.dart';
import 'package:clone_web/screen/myprofile.dart';
import 'package:clone_web/screen/home_screen.dart'; // Import your InstagramHomePage

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
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingPage(), // Start with the loading page
        '/home': (context) => const InstagramHomePage(), // Instagram home page
        '/profile': (context) => const MyProfile(), // Profile screen
      },
    );
  }
}
