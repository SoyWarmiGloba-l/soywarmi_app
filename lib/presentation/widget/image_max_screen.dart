import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageMaxScreen extends StatelessWidget {
  final String urlImage;
  const ImageMaxScreen({super.key, required this.urlImage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'Image $urlImage',
            child: Image.network(urlImage),
          ),
        ),
      ),
    );
  }
}