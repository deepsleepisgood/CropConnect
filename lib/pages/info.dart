import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  final String userId;

  const Information({super.key, required  this.userId});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Use'),
        centerTitle: true,
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
