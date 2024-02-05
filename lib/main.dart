import 'package:flutter/material.dart';
import 'package:cropconnect/pages/homepage.dart';
import 'package:cropconnect/pages/info.dart';
import 'package:get/get.dart';
import 'package:cropconnect/pages/localestring.dart';

void main() {
  runApp(const CropConnect());
}

class CropConnect extends StatelessWidget {
  const CropConnect({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalString(),
      locale: Locale('en','US'),
      home: HomePage(),
    );
  }
}
