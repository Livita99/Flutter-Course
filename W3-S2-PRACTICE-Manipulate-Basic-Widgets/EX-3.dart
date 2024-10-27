import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: const Center(
              child: Text(
                "OOP",
                style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: const Center(
              child: Text(
                "DART",
                style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Colors.blue[300]!,
                  Colors.blue[600]!,
                ])),
            child: const Center(
              child: Text(
                "FLUTTER",
                style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  ));
}
