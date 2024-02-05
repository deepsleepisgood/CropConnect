import 'dart:convert';
import 'package:cropconnect/pages/homepage.dart';
import 'package:cropconnect/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

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
  //language
  void _showPullUpDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                var locale = Locale('en','US');
                Get.updateLocale(locale);
              },
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                child: const Text('English',style: TextStyle(fontSize: 16),),
              ),
              TextButton(onPressed: (){
                var locale = Locale('hi','IN');
                Get.updateLocale(locale);
              },
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                child: const Text('हिंदी', style: TextStyle(fontSize: 16),),
              ),
            ],
          ),

        );
      },
    );
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF2EFEB),
        body: SingleChildScrollView(
          // backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: const Color.fromARGB(0, 59, 59, 59),
          //   elevation: 0,
          // ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text(
                    "r1".tr,
                    style: TextStyle(color: Color(0xFF88C431), fontSize: 25),
                  ),
                    Image.asset(
                      'assets/krishi.jpeg', // Replace with the actual path
                      width: 150,
                      height: 150,
                    ),
                  ]
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              style: TextStyle(color: Color(0xFFD49A42)),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "r2".tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Color(0xFFD49A42)),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "r3".tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _panController,
                              style: TextStyle(color: Color(0xFFD49A42)),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "r4".tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: TextStyle(color: Color(0xFFD49A42)),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "r5".tr,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    register();
                                  },
                                  child: Text(
                                    'r6'.tr,
                                    style: TextStyle(
                                        color: Color(0xFF88C431),
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>MyLogin(),));
                                  },
                                  child: Text(
                                    'r7'.tr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF88C431),
                                        fontSize: 18),
                                  ),
                                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _showPullUpDrawer(context);
                                  },

                                  child: Text(
                                    'lang'.tr,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Color(0xFF88C431),
                                        fontSize: 18),
                                  ),
                                  style: TextButton.styleFrom(backgroundColor: Colors.white),
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
        ),
      ),
    );
  }
}