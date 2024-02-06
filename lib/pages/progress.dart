import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation.dart';

class MyProgress extends StatefulWidget {
  final String userId;
  final String page;


  const MyProgress({Key? key, required this.userId, required this.page}) : super(key: key);

  @override
  _MyProgressState createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress> {
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

    return MaterialApp(
      home: Scaffold(
        drawer: const NavBar(
          userId: "userId",
          currentPage: "support",
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text('d3'.tr),
        ),
        backgroundColor: Color(0xFFF2EFEB),
        body: SingleChildScrollView(
          child:
          Column(
            children:[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.15),
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, 'login');
                              },
                              child: Text(
                                'p1'.tr,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Color(0xFF88C431),
                                    fontSize: 18),
                              ),
                              style: TextButton.styleFrom(backgroundColor: Colors.white),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, 'login');
                              },
                              child: Text(
                                'p2'.tr,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Color(0xFF88C431),
                                    fontSize: 18),
                              ),
                              style: TextButton.styleFrom(backgroundColor: Colors.white),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            LinearProgressIndicator(
                              backgroundColor: Colors.yellow[100],
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD49A42)),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 30, bottom: 30, left: 100.0, right:100.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFD49A42).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(context, 'login');
                                    },
                                    child: Text(
                                      'p3'.tr,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    style: TextButton.styleFrom(backgroundColor: Color(0xFFF2EFEB)),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'r2'.tr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'r3'.tr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _showPullUpDrawer(context);
                                  },
                                  child: Text(
                                    'lang'.tr,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                  style: TextButton.styleFrom(backgroundColor: Color(0xFFF2EFEB)),
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



