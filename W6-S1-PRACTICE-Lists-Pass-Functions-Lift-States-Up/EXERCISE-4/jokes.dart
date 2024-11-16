class Joke {
  final String title;
  final String description;

  Joke(this.title, this.description);
}

List<Joke> jokes = List.generate(
  20,
  (index) => Joke('Joke #${index + 1}', 'description of Joke #${index + 1}'),
);
