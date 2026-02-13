import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestHelpScreen extends StatefulWidget {
  const RequestHelpScreen({super.key});

  @override
  State<RequestHelpScreen> createState() => _RequestHelpScreenState();
}

class _RequestHelpScreenState extends State<RequestHelpScreen> {

  String selectedLevel = "Beginner";
  bool isUrgent = false;
  final TextEditingController descriptionController =
    TextEditingController();

String? selectedCategory;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Request Help",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Get help in just 15 minutes",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            const Text("What do you need help with?"),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "E.g., Help me understand React hooks patterns",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(18),
              ),
            ),


            const SizedBox(height: 24),

            const Text("Category"),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text("Select a category"),
                  items: const [
                    DropdownMenuItem(
                        value: "Coding", child: Text("Coding")),
                    DropdownMenuItem(
                        value: "Languages", child: Text("Languages")),
                    DropdownMenuItem(
                        value: "Design", child: Text("Design")),
                  ],
                  value: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },

                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text("Your skill level"),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                levelChip("Beginner"),
                levelChip("Intermediate"),
                levelChip("Advanced"),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text("Mark as urgent",
                          style:
                              TextStyle(fontWeight: FontWeight.w600)),
                      Text("Get help faster",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  Switch(
                    value: isUrgent,
                    activeColor: const Color(0xFF4A90E2),
                    onChanged: (value) {
                      setState(() {
                        isUrgent = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4A90E2),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
                onPressed: () async {

                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) return;

                  if (descriptionController.text.trim().isEmpty ||
                      selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")),
                    );
                    return;
                  }

                  await FirebaseFirestore.instance
                      .collection('requests')
                      .add({
                    'userId': user.uid,
                    'description': descriptionController.text.trim(),
                    'skillNeeded': selectedCategory,
                    'level': selectedLevel,
                    'isUrgent': isUrgent,
                    'duration': 15,
                    'status': 'open',
                    'createdAt': FieldValue.serverTimestamp(),
                  });

                  Navigator.pop(context);
                },

                child: const Text(
                  "Submit Request",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget levelChip(String level) {
    final isSelected = selectedLevel == level;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLevel = level;
        });
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A90E2)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          level,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
