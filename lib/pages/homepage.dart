import 'package:flutter/material.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:cropconnect/pages/navigation.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);

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
  void _showPullUpDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                var locale = Locale('en','US');
                Get.updateLocale(locale);
              },
                child: Text('English',style: TextStyle(fontSize: 16),),
                style: TextButton.styleFrom(foregroundColor: Colors.green),
              ),
              TextButton(onPressed: (){
                var locale = Locale('hi','IN');
                Get.updateLocale(locale);
              },
                child: Text('हिंदी', style: TextStyle(fontSize: 16),),
                style: TextButton.styleFrom(foregroundColor: Colors.green),

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
      drawer: NavBar(
        currentPage: "HomePage",
        userId: widget.userId,
      ),
      body: Container(
        decoration:const  BoxDecoration(
          image: DecorationImage(
            opacity: 80,
            image: AssetImage('assets/krishi.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30,),
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
            const SizedBox(height: 420,),
            TextButton(
              style:TextButton.styleFrom(foregroundColor: Colors.green),
              onPressed: () {
                _showPullUpDrawer(context);
              },
              child: Text('lang'.tr,style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
