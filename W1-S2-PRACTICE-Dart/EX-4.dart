void main() {
  // Map of pizza prices
  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  // Example order
  const order = ['margherita', 'pepperoni', 'pineapple'];

  // Your code
  double sum = 0.0;
  List<String> invalidItems = [];

  for (var pizza in order) {
    if (pizzaPrices.containsKey(pizza)) {
      sum += pizzaPrices[pizza] ?? 0;
    } else {
      invalidItems.add(pizza);
    }
  }

  print("Total: \$$sum");

  if (invalidItems.isNotEmpty) {
    print("${invalidItems.join(', ')} pizza is not on the menu");
  }
}
