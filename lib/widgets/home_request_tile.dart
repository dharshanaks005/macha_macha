import 'package:flutter/material.dart';

class HomeRequestTile extends StatelessWidget {
  final String userName;
  final String reliability;
  final String title;
  final String category;
  final bool isUrgent;
  final VoidCallback onTap;

  const HomeRequestTile({
    super.key,
    required this.userName,
    required this.reliability,
    required this.title,
    required this.category,
    required this.isUrgent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=1"),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600)),
                  Text("$reliability reliability",
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey)),
                ],
              )
            ],
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _chip(category, Colors.grey.shade200),
              const SizedBox(width: 8),
              if (isUrgent)
                _chip("Urgent", Colors.blue.shade100,
                    textColor: Colors.blue),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: onTap,
              child: const Text("Help"),
            ),
          )
        ],
      ),
    );
  }

  Widget _chip(String text, Color bgColor,
      {Color textColor = Colors.black}) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: textColor),
      ),
    );
  }
}
