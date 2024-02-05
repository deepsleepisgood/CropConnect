import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:cropconnect/pages/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String userId;
  String page;
  HomePage({Key? key, required this.userId, required this.page}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final dateTime = DateTime.now();
class _HomePageState extends State<HomePage> {
  XFile? _image;

//Function to access Camera
  Future _pickImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
  // FUNCTION TO UPLOAD IMAGE ON THE BACKEND
  Future<void> _uploadImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, dynamic>? decodedToken = JwtDecoder.decode(token!);
    String? userId = decodedToken['userId'];

    // Prepare the request body as JSON
    var requestBody = {
      'userId': userId,
      'file': {
        'originalname': _image?.name ?? '', // Assuming _image is an XFile
        'data': base64Encode(await _image!.readAsBytes()), // Convert image to base64
      },
    };

    try {
      var response = await http.post(
        Uri.parse('/claimInsurance'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Image uploaded');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image upload: $e');
    }
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
      ),
      drawer: NavBar(
        currentPage: widget.page,
        userId: widget.userId,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 150,
            image: AssetImage('assets/krishi.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 0.0, left: 10.0, right: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'hello'.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dateTime.format(AmericanDateFormats.dayOfWeek),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 90),
                      // Add Image Button
                      IconButton(
                        icon: const Icon(Icons.account_circle,size: 45),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 150,
                  ),
           //container(
           //padding: const EdgeInsets.all(15.0),
           //decoration: const BoxDecoration(
           //  shape: BoxShape.circle,
           //  color: Colors.green, // Customize the color as needed
           //),
           //child: IconButton(onPressed: (){
           //  _pickImage(true);
           //},
           //    alignment: Alignment.center,
           //    icon: const Icon(Icons.add_a_photo,size: 30, color: Colors.white,)),
           //
                ],
              ),
            ),
            const SizedBox(height: 380,),
            TextButton(
              style:TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () {
                _showPullUpDrawer(context);
              },
              child: Text('lang'.tr, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 30.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 630,),
            FloatingActionButton(
              onPressed: (){_pickImage(true);},
              child: Icon(Icons.add_a_photo),
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
