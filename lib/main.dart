import 'package:flutter/material.dart';
import 'package:cropconnect/pages/homepage.dart';
import 'pages/register.dart';
import 'pages/login.dart';
import 'package:get/get.dart';
import 'package:cropconnect/pages/localestring.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  bool isAuthenticated = token != null && !JwtDecoder.isExpired(token);
  String userId = "";
  if (token != null) {
    Map<String, dynamic>? decodedToken = JwtDecoder.decode(token);
    // Explicitly cast the value to an integer
    userId = decodedToken['user_id']?.toString() ?? '';
    runApp(CropConnect(isAuthenticated: isAuthenticated, userId: userId));
  } else {
    runApp(CropConnect(isAuthenticated: isAuthenticated, userId: userId));
  }
}

class CropConnect extends StatelessWidget {
  final bool isAuthenticated;
  final String userId;
  const CropConnect({Key? key, required this.isAuthenticated, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalString(),
      locale: Locale('en', 'US'),
      home: MyRegister(),
      //home: isAuthenticated ? HomePage(userId: userId, page: "home") : const MyRegister(),
    );
  }
}

