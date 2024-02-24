import 'dart:async';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  void _myFunction() {
    // Your function logic here
    _startListening;
  }

  void startTimer() {
    const duration = Duration(minutes: 10);
    const totalDuration = Duration(hours: 1);

    Timer.periodic(duration, (timer) {
      // Call your function here
      _myFunction();

      // Check if one hour has elapsed
      if (timer.tick >= totalDuration.inMinutes ~/ duration.inMinutes) {
        timer.cancel(); // Cancel the timer after one hour
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
