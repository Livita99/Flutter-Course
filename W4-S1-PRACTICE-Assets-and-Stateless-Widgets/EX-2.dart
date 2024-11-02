import 'package:flutter/material.dart';

enum Product {
  dart("Dart", "the best object language", "assets/logo/dart.png"),
  flutter(
      "Flutter", "the best mobile widget library", "assets/logo/flutter.png"),
  firebase("Firebase", "the best cloud database", "assets/logo/firebase.png");

  final String title;
  final String description;
  final String image;

  const Product(this.title, this.description, this.image);
}

void main() => runApp(MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: const Text('Products'),
            backgroundColor: Colors.white,
          ),
          body: const Padding(
            padding: EdgeInsets.all(15),
            child: Column(children: [
              ProductCard(product: Product.dart),
              Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              ProductCard(product: Product.flutter),
              Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              ProductCard(product: Product.firebase),
            ]),
          )),
    ));

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(product.image,
                width: 100, height: 100, alignment: Alignment.centerLeft),
            const SizedBox(height: 5),
            Text(product.title,
                style: const TextStyle(
                  fontSize: 30,
                )),
            const SizedBox(height: 5),
            Text(product.description,
                style: const TextStyle(
                  fontSize: 13,
                ))
          ],
        ),
      ),
    );
  }
}
