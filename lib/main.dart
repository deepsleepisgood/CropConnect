import 'package:flutter/material.dart';
import 'package:cropconnect/pages/homepage.dart';

void main() {
  runApp(const CropConnect());
}

class CropConnect extends StatelessWidget {
  const CropConnect({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
