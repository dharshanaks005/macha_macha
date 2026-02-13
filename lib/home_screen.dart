import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:macha_macha/widgets/home_request_tile.dart';
import 'request_help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // 🔹 CREATE SESSION FUNCTION
  Future<void> createSession() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('sessions').add({
        'userA': user.uid,
        'userB': null, // will be assigned later
        'status': 'pending',
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Session created successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      // 🔹 FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4A90E2),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RequestHelpScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Alex Chen",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          NetworkImage("https://i.pravatar.cc/150?img=3"),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              // 🔹 START SESSION BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: createSession,
                  child: const Text(
                    "Start Session",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 REQUEST LIST
              Expanded(
                child: ListView(
                  children: [

                    HomeRequestTile(
                      userName: "Sarah Johnson",
                      reliability: "96%",
                      title: "Help me understand React hooks patterns",
                      category: "Web Development",
                      isUrgent: true,
                      onTap: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                    ),

                    const SizedBox(height: 20),

                    HomeRequestTile(
                      userName: "Michael Lee",
                      reliability: "92%",
                      title: "Quick Spanish conversation practice",
                      category: "Languages",
                      isUrgent: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                    ),

                    const SizedBox(height: 20),

                    HomeRequestTile(
                      userName: "Emma Davis",
                      reliability: "98%",
                      title: "Feedback on my UI design mockup",
                      category: "Design",
                      isUrgent: false,
                      onTap: () {
                        Navigator.pushNamed(context, '/chat');
                      },
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
