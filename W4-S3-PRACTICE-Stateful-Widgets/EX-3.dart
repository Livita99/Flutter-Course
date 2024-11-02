import 'package:flutter/material.dart';

List<String> images = [
  "assets/w4-s2/bird.jpg",
  "assets/w4-s2/bird2.jpg",
  "assets/w4-s2/insect.jpg",
  "assets/w4-s2/girl.jpg",
  "assets/w4-s2/man.jpg",
];

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageViewer(),
    ));

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});

  @override
  State<ImageViewer> createState() => _ImageViewer();
}

class _ImageViewer extends State<ImageViewer> {
  int _index = 0;

  void _nextImage() {
    setState(() {
      _index = (_index + 1) % images.length;
    });
  }

  void _previousImage() {
    setState(() {
      _index = (_index - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Image viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the previous image',
            onPressed: _previousImage,
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next image',
            onPressed: _nextImage,
          ),
        ],
      ),
      body: Image.asset(images[_index]),
    );
  }
}
