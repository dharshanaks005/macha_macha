import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Session - 15:00"),
        backgroundColor: const Color(0xFF4A90E2),
      ),
      body: const Center(
        child: Text("Chat UI goes here"),
      ),
    );
  }
}
