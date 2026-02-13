import 'package:flutter/material.dart';

class MyRequestTile extends StatelessWidget {
  final String title;
  final String category;
  final String status;
  final Color statusColor;
  final String date;
  final VoidCallback onDelete;

  const MyRequestTile({
    super.key,
    required this.title,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.date,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔹 Title + Delete
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 🔹 Category + Status Chips
          Row(
            children: [
              _chip(category, Colors.grey.shade200),
              const SizedBox(width: 8),
              _chip(
                status,
                statusColor.withOpacity(0.2),
                textColor: statusColor,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🔹 Date
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color bgColor,
      {Color textColor = Colors.black}) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }
}
