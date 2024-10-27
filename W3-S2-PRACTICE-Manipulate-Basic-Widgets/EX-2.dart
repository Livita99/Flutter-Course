import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.all(50),
      color: Colors.blue[300],
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[600],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Center(
          child: Text(
            "CADT STUDENTS",
            style: TextStyle(
                fontSize: 35,
                decoration: TextDecoration.none,
                color: Colors.white),
          ),
        ),
      ),
    ),
  ));
}
