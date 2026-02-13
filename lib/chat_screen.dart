import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
Future<void> sendMessage(String sessionId, String message) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  await FirebaseFirestore.instance
      .collection('sessions')
      .doc(sessionId)
      .collection('messages')
      .add({
        'senderId': user.uid,
        'text': message,
        'timestamp': Timestamp.now(),
      });
}

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
