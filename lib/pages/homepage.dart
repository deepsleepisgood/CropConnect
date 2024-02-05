import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
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
                        const Text(
                          'Krishi Raksha',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
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
                    SizedBox(width: 80),
                    // Add Image Button
                    IconButton(
                      icon: Icon(Icons.account_circle,size: 45),
                      onPressed: () {
                        // Handle image button press
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
           Container(
             padding: EdgeInsets.all(16.0),
             decoration: const BoxDecoration(
               shape: BoxShape.circle,
               color: Colors.green, // Customize the color as needed
             ),
             child: IconButton(onPressed: (){
               _pickImage(true);
             },
                 alignment: Alignment.center,
                 icon: Icon(Icons.add_a_photo,size: 30,
                 )),
           )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
