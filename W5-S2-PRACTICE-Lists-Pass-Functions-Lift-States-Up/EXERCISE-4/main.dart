import 'package:flutter/material.dart';
import 'jokes.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: appColor,
            title: const Text("Favorite Jokes"),
          ),
          body: const JokeList(),
        ),
      ),
    );

int? bestJokeIndex;

class JokeList extends StatelessWidget {
  const JokeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        return FavoriteCard(
          joke: jokes[index],
          isBestJoke: bestJokeIndex == index,
          onFavoriteClick: () {
            if (bestJokeIndex == index) {
              bestJokeIndex = null;
            } else {
              bestJokeIndex = index;
            }
            (context as Element).markNeedsBuild();
          },
        );
      },
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Joke joke;
  final bool isBestJoke;
  final VoidCallback onFavoriteClick;

  const FavoriteCard({
    super.key,
    required this.joke,
    required this.isBestJoke,
    required this.onFavoriteClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.title,
                  style:
                      TextStyle(color: appColor, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(joke.description)
              ],
            ),
          ),
          IconButton(
              onPressed: onFavoriteClick,
              icon: Icon(
                isBestJoke ? Icons.favorite : Icons.favorite_border,
                color: isBestJoke ? Colors.red : Colors.grey,
              ))
        ],
      ),
    );
  }
}
