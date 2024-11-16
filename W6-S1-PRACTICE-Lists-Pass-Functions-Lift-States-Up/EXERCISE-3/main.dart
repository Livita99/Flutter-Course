import 'package:flutter/material.dart';
import 'package:flutter_workspace/W6-S1-Lists-Pass-Functions-Lift-States-Up/EXERCISE-3/screen/welcome.dart';
import 'package:flutter_workspace/W6-S1-Lists-Pass-Functions-Lift-States-Up/EXERCISE-3/screen/temperature.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {
  bool _isWelcomeScreen = true;

  void _toggleScreen() {
    setState(() {
      _isWelcomeScreen = !_isWelcomeScreen;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _isWelcomeScreen
              ? Welcome(onNavigate: _toggleScreen)
              : Temperature(onNavigate: _toggleScreen),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}
