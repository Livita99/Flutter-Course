import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScoreCard(
                      title: "My score in Flutter",
                      score: 50,
                      barColor: Colors.blue),
                  const SizedBox(height: 18),
                  ScoreCard(
                      title: "My score in Dart",
                      score: 70,
                      barColor: Colors.red),
                  const SizedBox(height: 18),
                  ScoreCard(
                      title: "My score in React",
                      score: 90,
                      barColor: Colors.purple),
                ],
              )),
        ),
      ),
    ));

class ScoreCard extends StatefulWidget {
  final String title;
  final int score;
  final Color barColor;

  const ScoreCard({
    super.key,
    required this.title,
    required this.score,
    this.barColor = Colors.green,
  });

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  late int currentScore;

  @override
  void initState() {
    super.initState();
    currentScore = widget.score;
  }

  void incrementScore() {
    setState(() {
      if (currentScore < 100) currentScore += 10;
    });
  }

  void decrementScore() {
    setState(() {
      if (currentScore > 0) currentScore -= 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(
            child: Text(widget.title,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey,
                )),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(
              onPressed: decrementScore,
              icon: Icon(Icons.remove),
            ),
            const SizedBox(width: 90),
            IconButton(
              onPressed: incrementScore,
              icon: Icon(Icons.add),
            ),
          ]),
          const SizedBox(height: 10),
          Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: currentScore / 100,
                  color: widget.barColor,
                  backgroundColor: Colors.white,
                ),
              ))
        ]),
      ),
    );
  }
}
