import 'package:flutter/material.dart';
import 'package:macha_macha/widgets/my_request_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [

                    const CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          NetworkImage("https://i.pravatar.cc/150?img=3"),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Alex Chen",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Member since Jan 2026",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(child: statCard("Karma", "245")),
                        const SizedBox(width: 16),
                        Expanded(child: statCard("Reliability", "98%")),
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

                    MyRequestTile(
                      title: "Help with Python data structures",
                      category: "Programming",
                      status: "Completed",
                      statusColor: Colors.green,
                      date: "Feb 10, 2026",
                      onDelete: () {
                        print("Delete pressed");
                      },
                    ),

                    const SizedBox(height: 20),

                    MyRequestTile(
                      title: "Resume review feedback",
                      category: "Career",
                      status: "Pending",
                      statusColor: Colors.orange,
                      date: "Feb 13, 2026",
                      onDelete: () {
                        print("Delete pressed");
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
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
