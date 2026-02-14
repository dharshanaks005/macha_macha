import 'dart:async';
import 'package:flutter/material.dart';
import 'rating_screen.dart';

class ChatScreen extends StatefulWidget {
  final String sessionId;

  const ChatScreen({super.key, required this.sessionId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Timer _timer;
  int _remainingSeconds = 1 * 60; // 15 minutes

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        showTimeUpDialog();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String formatTime(int seconds) {
    int min = seconds ~/ 60;
    int sec = seconds % 60;
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  void showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Session Ended"),
        content: const Text("Your 15-minute session is over. Quit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Continue"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => RatingScreen(sessionId: widget.sessionId),
                ),
              );
            },
            child: const Text("Quit"),
          ),
        ],
      ),
    );
  }

  void forceStop() {
    _timer.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Force Stop"),
        content: const Text("Did you tap Force Stop by mistake?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startTimer();
            },
            child: const Text("Go Back"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => RatingScreen(sessionId: widget.sessionId),
                ),
              );
            },
            child: const Text("Quit Session"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Session"),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop_circle),
            onPressed: forceStop,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Time Left: ${formatTime(_remainingSeconds)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          /// Your existing chat UI goes here
          const Expanded(
            child: Center(child: Text("Chat Messages Here")),
          ),
        ],
      ),
    );
  }
}
