import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Use'),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/info1.jpg',alignment: Alignment.center),
            const SizedBox(height: 10,),
            Text('Welcome to Krishi Raksha,')
          ],
        ),
      ),
    );
  }
}
