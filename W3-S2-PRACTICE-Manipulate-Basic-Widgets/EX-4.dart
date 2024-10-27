import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(25),
      child: Column(
        children: [
          CustomCard(
            text: "OOP",
            color: Colors.blue[100]!,
            useGradient: false,
          ),
          CustomCard(
            text: "DART",
            color: Colors.blue[300]!,
            useGradient: false,
          ),
          CustomCard(
            text: "FLUTTER",
            color: Colors.blue[600]!,
            useGradient: true,
            gradientColors: [
              Colors.blue[300]!,
              Colors.blue[900]!,
            ],
          )
        ],
      ),
    ),
  ));
}

class CustomCard extends StatelessWidget {
  final String text;
  final Color color;
  final bool useGradient;
  final List<Color>? gradientColors;

  const CustomCard({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.useGradient = false,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: useGradient ? null : color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: useGradient
            ? LinearGradient(
                colors: gradientColors ?? [color],
              )
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 30,
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
