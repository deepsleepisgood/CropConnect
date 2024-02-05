import 'dart:convert';
import 'package:cropconnect/pages/homepage.dart';
import 'package:cropconnect/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  Color buttonColor = const Color(0xFF88C431);
  late SharedPreferences prefs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String userId = "";

  Future<void> register() async {
    const String uri = "http://172.16.22.254:5000/register";
    Map<String, String> data = {
      "Name" : _nameController.text,
      "State" : "Haryana",
      "Phone Number" : _phoneController.text,
      "PAN" : _panController.text,
      "Password" : _passwordController.text
    };
    try{
      final response = await http.post(
        Uri.parse(uri),
        body : (data),
      );
      if (response.statusCode == 200){
        final Map<String, dynamic> responseBody = json.decode(response.body);
        var token = responseBody['token'];
        userId = token['user_id'];
        prefs.setString('token', token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(userId: userId, page: "home"),));
        print("Successful registration");
      } else {
        print("Error : ${response.statusCode}");
        print("Response : ${response.body}");
      }
    }
    catch (error){
      print("Error : $error");
    }
  }
  //INITIALIZING SHARED PREFS
  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }
  @override
  void initState(){
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create an account",
                      style: TextStyle(color: Color(0xFF88C431), fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle(color: Color(0xFFD49A42)),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Color(0xFFD49A42)),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Phone Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _panController,
                            style: TextStyle(color: Color(0xFFD49A42)),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "PAN Number",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Color(0xFFD49A42)),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: register,
                                style: TextButton.styleFrom(backgroundColor: Colors.white),
                                child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xFF88C431),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyLogin(),));
                                },
                                style: TextButton.styleFrom(backgroundColor: Colors.white),
                                child: const Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xFF88C431),
                                      fontSize: 18),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(backgroundColor: Colors.white),
                                child: const Text(
                                  'Language',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Color(0xFF88C431),
                                      fontSize: 18),
                                ),

                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}
