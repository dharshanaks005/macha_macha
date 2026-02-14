import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macha_macha/widgets/my_request_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text("Not logged in")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, userSnapshot) {

            if (!userSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final userData =
              userSnapshot.data?.data() as Map<String, dynamic>? ?? {};

            final name = userData['name'] ?? '';
            final karma = userData['karmaPoints'] ?? 10;
            final rating = userData['rating'] ?? 95;

            return Column(
              children: [

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [

                        const CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xFF4A90E2),
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),


                        const SizedBox(height: 16),

                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          "Member",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          children: [
                            Expanded(
                                child: statCard("Karma", karma.toString())),
                            const SizedBox(width: 16),
                            Expanded(
                                child: statCard(
                                    "Rating", "$rating ⭐")),
                          ],
                        ),

                        const SizedBox(height: 30),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "My Requests",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🔥 MY REQUESTS LIST
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('requests')
                              .where('userId',
                                  isEqualTo: currentUser.uid)
                              .snapshots(),
                          builder: (context, snapshot) {

                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            final docs = snapshot.data!.docs;

                            if (docs.isEmpty) {
                              return const Text(
                                  "No requests yet");
                            }

                            return Column(
                              children: docs.map((doc) {

                                final data = doc.data()
                                    as Map<String, dynamic>;

                                final status =
                                    data['status'] ?? 'open';

                                Color statusColor =
                                    Colors.orange;

                                if (status == 'completed') {
                                  statusColor =
                                      Colors.green;
                                } else if (status ==
                                    'accepted') {
                                  statusColor =
                                      Colors.blue;
                                }

                                return Padding(
                                  padding:
                                      const EdgeInsets.only(
                                          bottom: 16),
                                  child: MyRequestTile(
                                    title: data['description'] ?? '',
                                    category:
                                        data['skillNeeded'] ?? '',
                                    status: status,
                                    statusColor: statusColor,
                                    date: '',
                                    onDelete: () async {
                                      await FirebaseFirestore
                                          .instance
                                          .collection(
                                              'requests')
                                          .doc(doc.id)
                                          .delete();
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .signOut();
                        Navigator.pushReplacementNamed(
                            context, '/login');
                      },
                      child: const Text(
                        "Logout",
                        style:
                            TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget statCard(String title, String value) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Text(title,
              style:
                  const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
