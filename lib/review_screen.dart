import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewScreen extends StatefulWidget {
  final String sessionId;

  const ReviewScreen({super.key, required this.sessionId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  bool? misleading;
  final TextEditingController controller = TextEditingController();

  void submitReview() async {
    await FirebaseFirestore.instance.collection('reviews').add({
      'sessionId': widget.sessionId,
      'misleading': misleading,
      'feedback': controller.text,
      'timestamp': Timestamp.now(),
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Thank You"),
        content: const Text("Session ended successfully."),
        actions: [
          ElevatedButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("Go Home"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Session Review")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Was this session misleading?"),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: misleading,
                  onChanged: (v) => setState(() => misleading = v),
                ),
                const Text("Yes"),
                Radio<bool>(
                  value: false,
                  groupValue: misleading,
                  onChanged: (v) => setState(() => misleading = v),
                ),
                const Text("No"),
              ],
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Additional feedback (optional)",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: misleading == null ? null : submitReview,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
