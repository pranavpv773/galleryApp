import 'dart:io';
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key, this.image}) : super(key: key);
  final dynamic image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(76, 109, 106, 106),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever_rounded,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: image,
          child: Image.file(
            File(
              image.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
