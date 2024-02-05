import 'package:flutter/material.dart';
import 'package:cropconnect/pages/homepage.dart';
import 'package:cropconnect/pages/info.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NavBar extends StatefulWidget {
  final String userId;
  final String currentPage;
  const NavBar({super.key, required this.userId, required this.currentPage});
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.7,
      elevation: 2.5,
      shadowColor: Colors.white70,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          DrawerHeader(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                //image: Image(image: AssetImage("assets/images/kimi no nawa.jpeg"),),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Image(
                image: AssetImage('assets/krishi.jpeg'),
              )
            // const Text("SWASTH", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 20,
              color: Colors.black,
            ),
            title: const Text(
              "Home",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(userId: widget.userId),
                  ));
            },
            tileColor: widget.currentPage == "Home" ? Colors.white54 : null,
          ),
          ListTile(
            leading: const Icon(
              Icons.info_outline_rounded,
              size: 20,
              color: Colors.black,
            ),
            title: const Text(
              "Information",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Information(
                        userId: widget.userId,
                      )));
            },
            tileColor: widget.currentPage == "Information" ? Colors.white54 : null,
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.file_copy_outlined,
          //     size: 20,
          //     color: Colors.black,
          //   ),
          //   title: const Text(
          //     "Files",
          //     style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold),
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => FileListPage(userId: widget.userId),
          //         ));
          //   },
          //   tileColor: widget.currentPage == "Files" ? Colors.white54 : null,
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.settings,
          //     size: 20,
          //     color: Colors.black,
          //   ),
          //   title: const Text(
          //     "Settings",
          //     style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold),
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => SettingsPage(userId: widget.userId),
          //         ));
          //   },
          //   tileColor: widget.currentPage == "Settings" ? Colors.white54 : null,
          // ),

          // ListTile(
          //
          //   leading: const Icon(
          //     Icons.logout,
          //     size: 20,
          //     color: Colors.black,
          //   ),
          //   title: const Text(
          //     "Logout",
          //     style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold),
          //   ),
          //   onTap: () async {
          //     bool confirmLogout = await showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text('Logout'),
          //           content: const Text('Are you sure you want to logout?'),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(context).pop(false);
          //               },
          //               child: const Text('No'),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 Navigator.of(context).pop(true);
          //               },
          //               child: const Text('Yes'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //     if (confirmLogout == true) {
          //       SharedPreferences prefs = await SharedPreferences.getInstance();
          //       await prefs.remove('token');
          //       Navigator.popAndPushNamed(context, "login");
          //     }
          //   },
          //   tileColor: widget.currentPage == "Logout" ? Colors.white54 : null,
          // ),
        ],
      ),
    );
  }
}
