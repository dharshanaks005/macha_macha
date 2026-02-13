import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';
import 'signup_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/chat': (context) => const ChatScreen(),
        '/signup': (context) => const SignUpScreen(),

      },
    );
  }
}
