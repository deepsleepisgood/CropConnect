import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'localestring.dart';
import 'navigation.dart';


class Information extends StatefulWidget {
  final String userId;
  String page;
  Information({super.key, required  this.userId, required this.page});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  void _showPullUpDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          padding: EdgeInsets.all(10.0),
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
      backgroundColor: Color(0xFFF2EFEB),
      drawer: const NavBar(
        userId: "userId",
        currentPage: "info",
      ),
      appBar: AppBar(
        title: Text('how'.tr),
        centerTitle: true,
        backgroundColor: const Color(0xFF62BA47),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text('info'.tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Divider(color: Colors.black, height: 10),
            const SizedBox(height: 20,),
            Image.asset('assets/1.png',alignment: Alignment.center),
            const SizedBox(height: 10,),
            Text('a'.tr,style: TextStyle(fontSize: 24),),
            const SizedBox(height: 20,),
            Image.asset('assets/2.png',alignment: Alignment.center,),
            const SizedBox(height: 10,),
            Text('b'.tr,style: TextStyle(fontSize: 24),),
            const SizedBox(height: 20,),
            Image.asset('assets/3.png',alignment: Alignment.center,),
            const SizedBox(height: 10,),
            Text('c'.tr,style: TextStyle(fontSize: 24),),
            const SizedBox(height: 20,),
            Image.asset('assets/4.png',alignment: Alignment.center,),
            const SizedBox(height: 10,),
            Text('d'.tr,style: TextStyle(fontSize: 24),),
            const SizedBox(height: 20,),
            Image.asset('assets/5.png',alignment: Alignment.center,),
            const SizedBox(height: 10,),
            Text('e'.tr,style: TextStyle(fontSize: 24),),
            const SizedBox(height: 20,),
            Image.asset('assets/6.png',alignment: Alignment.center,),
            const SizedBox(height: 10,),
            Text('f'.tr,style: TextStyle(fontSize: 24),),
          ],
        ),
      ),
      bottomNavigationBar:
      TextButton(
        style:TextButton.styleFrom(foregroundColor: Colors.green),
        onPressed: () {
          _showPullUpDrawer(context);
        },
        child: Text('lang'.tr,style: TextStyle(fontSize: 16),),
      ),
    );
  }
}
