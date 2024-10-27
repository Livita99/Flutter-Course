import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
        home: Scaffold(
      body: Center(
        child: Text(
          'Hello my name is Vita!',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 50,
          ),
        ),
      ),
    )),
  );
}
