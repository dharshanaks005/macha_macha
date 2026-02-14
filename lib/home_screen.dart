import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macha_macha/chat_screen.dart';

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
      final currentUser = FirebaseAuth.instance.currentUser!;

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

              const SizedBox(height: 30),

              // 🔹 REQUEST LIST
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .where('status', isEqualTo: 'open')
                      .snapshots(),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final docs = snapshot.data!.docs;

                    if (docs.isEmpty) {
                      return const Center(child: Text("No requests yet"));
                    }

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index];

                        return HomeRequestTile(
                          userName: "User", // we improve later
                          reliability: "95%",
                          title: data['description'],
                          category: data['skillNeeded'],
                          isUrgent: false,
                          onTap: () async {
                            final docRef = await FirebaseFirestore.instance
                                .collection('sessions')
                                .add({
                              'status': 'active',
                              'createdAt': FieldValue.serverTimestamp(),
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(sessionId: docRef.id),
                              ),
                            );
                          },

                          
                        );
                      },
                    );
                  },
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  Future<void> acceptRequest(String requestId, BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final requestRef =
      FirebaseFirestore.instance.collection('requests').doc(requestId);

  try {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(requestRef);

      if (!snapshot.exists) {
        throw Exception("Request not found");
      }

      if (snapshot['status'] != 'open') {
        throw Exception("Already accepted");
      }

      // Create session
      final sessionRef =
          FirebaseFirestore.instance.collection('sessions').doc();

      transaction.set(sessionRef, {
        'userA': snapshot['createdBy'],
        'userB': user.uid,
        'status': 'active',
        'startedAt': FieldValue.serverTimestamp(),
      });

      // Update request
      transaction.update(requestRef, {
        'status': 'accepted',
        'acceptedBy': user.uid,
        'sessionId': sessionRef.id,
      });
    });

    // Navigate helper to chat
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(sessionId: requestId),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Too late! Someone already accepted.")),
    );
  }
}

}
