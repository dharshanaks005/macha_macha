import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingScreen extends StatefulWidget {
  final String sessionId;

  const RatingScreen({super.key, required this.sessionId});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int selectedRating = 0;
  bool isSubmitting = false;

  Future<void> submitRating() async {
    if (selectedRating == 0) return;

    setState(() => isSubmitting = true);

    try {
      await FirebaseFirestore.instance
          .collection('sessions')
          .doc(widget.sessionId)
          .update({
        'rating': selectedRating,
        'startedAt': FieldValue.serverTimestamp(),
      });

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        Icons.star,
        color: index <= selectedRating ? Colors.amber : Colors.grey,
        size: 36,
      ),
      onPressed: () {
        setState(() {
          selectedRating = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rate Session")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "How was the session?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => buildStar(index + 1)),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: isSubmitting ? null : submitRating,
            child: isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Submit Rating"),
          ),
        ],
      ),
    );
  }
}
