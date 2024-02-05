import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
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
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2EFEB),
        // image: DecorationImage(
        //     image: AssetImage('assets/blue2.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(
                  'assets/3bgrem.png', // Replace with the actual path
                  width: 500,
                  height: 500,
                ),
              ],
            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
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
                          TextField(
                            controller: _passwordController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(),
                            obscureText: true,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                style: TextButton.styleFrom(backgroundColor: Colors.white),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Color(0xFF88C431),
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                style: TextButton.styleFrom(backgroundColor: Colors.white),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color(0xFF88C431),
                                      fontSize: 18),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigator.pushNamed(context, 'login');
                                },
                                child: Text(
                                  'Language',
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
        bottomNavigationBar:
        TextButton(
          style:TextButton.styleFrom(foregroundColor: Colors.green),
          onPressed: () {
            _showPullUpDrawer(context);
          },
          child: Text('lang'.tr,style: TextStyle(fontSize: 16),),
        ),
      ),
    );
  }
}
