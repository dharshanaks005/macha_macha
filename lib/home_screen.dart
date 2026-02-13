import 'package:flutter/material.dart';
import 'package:macha_macha/widgets/home_request_tile.dart';
import 'request_help_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      // Floating Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4A90E2),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RequestHelpScreen(),
            ),
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
                      backgroundImage: NetworkImage(
                          "https://i.pravatar.cc/150?img=3"),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 30),

              // 🔹 REQUEST LIST
              Expanded(
                child: ListView(
                  children: [

                    HomeRequestTile(
                      userName: "Sarah Johnson",
                      reliability: "96%",
                      title:
                          "Help me understand React hooks patterns",
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
                      title:
                          "Quick Spanish conversation practice",
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
