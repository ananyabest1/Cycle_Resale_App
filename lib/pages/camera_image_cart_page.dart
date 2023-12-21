import 'package:flutter/material.dart';
import 'dart:typed_data';

class CameraImagePage extends StatelessWidget {
  final Uint8List? image;
  const CameraImagePage({Key? key, required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Detail"),
      ),
      body: Center(
        child: Image.memory(image!),
      ),
    );
  }
}

