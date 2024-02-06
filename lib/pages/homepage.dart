import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:cropconnect/pages/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  final String userId;
  String page;
  HomePage({Key? key, required this.userId, required this.page})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dateTime = DateTime.now();
  XFile? _image;
  List<dynamic> items = [];
  Location location = Location();
  double? latitude = 0;
  double? longitude = 0;

  Future _findlocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
      print("${latitude}, ${longitude}");
    });
  }

//Function to access Camera
  Future _pickImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (image != null) {
      await _findlocation();
      setState(() {
        _image = image;
      });
      try {
        _uploadImage(_image!, latitude, longitude);
      } catch (error) {
        print("ERROR : ${error}");
      }
    }
  }

  // FUNCTION TO UPLOAD IMAGE ON THE BACKEND
  Future<void> _uploadImage(
      XFile imagePath, double? latitude, double? longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, dynamic>? decodedToken = JwtDecoder.decode(token!);
    String? userId = decodedToken['userId'];

    // Prepare the request body as JSON
    var requestBody = {
      'userId': widget.userId,
      'file': {
        'originalname': imagePath.name ?? '', // Assuming _image is an XFile
        'data': base64Encode(
            await imagePath.readAsBytes()), // Convert image to base64
      },
      'Geotag': {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
    try {
      var response = await http.post(
        Uri.parse('http://51.120.6.142:80/claimInsurance'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Image and Geotagging uploaded');
      } else {
        print(
            'Image and Geotagging upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during image and Geotagging upload: $e');
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
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  var locale = Locale('en', 'US');
                  Get.updateLocale(locale);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                child: const Text(
                  'English',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  var locale = Locale('hi', 'IN');
                  Get.updateLocale(locale);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                child: const Text(
                  'हिंदी',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> fetchLogs() async {
    const String uri = "http://51.120.6.142:80/logs";
    final response = await http.post(Uri.parse(uri),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": widget.userId,
        }));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        items = List<dynamic>.from(data);
      });
    } else {
      print("Error in fetching user logs");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLogs();
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
            opacity: 190,
            image: AssetImage('assets/krishi.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
              TextButton(onPressed: (){}, child: Image.asset('assets/farmerrembg.png',height: 50,width: 50,)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              //decoration: BoxDecoration(),
              child: items.isEmpty ? const Center(
                child: Text(
                  'No logs available',
                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                ),) : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 6,
                          )
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          items[index]['Time Of Upload'],
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 520,
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () {
                _showPullUpDrawer(context);
              },
              child: Text(
                'lang'.tr,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(left: 30.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 670,
            ),
            FloatingActionButton(
              onPressed: () {
                _pickImage(true);
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_a_photo),
            ),
          ],
        ),
      ),
    );
  }
}