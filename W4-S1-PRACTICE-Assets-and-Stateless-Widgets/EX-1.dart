import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('My Hobbies'),
              backgroundColor: Colors.pink,
            ),
            body: const Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  HobbyCard(
                      title: "Traveling",
                      icon: Icons.travel_explore,
                      cardBackgroundColor: Colors.green),
                  SizedBox(height: 10),
                  HobbyCard(
                      title: "Skating",
                      icon: Icons.skateboarding,
                      cardBackgroundColor: Colors.blueGrey),
                ],
              ),
            )),
      ),
    );

class HobbyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color cardBackgroundColor;

  const HobbyCard({
    super.key,
    required this.title,
    required this.icon,
    this.cardBackgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          children: [
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 20),
            Text(title,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
