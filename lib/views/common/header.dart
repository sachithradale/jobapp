import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';

class customizedAppBar{
  customizedAppBar({required this.title});
  String title;
  AppBar header(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: AppFonts.heading(
          title,
          Colors.white,
      ),
    );
  }
}

class CustomizedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'SimplyHired',
              style: TextStyle(
                fontFamily: 'poppins',
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: AppFonts.normal('Home', Colors.black),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: AppFonts.normal('Profile', Colors.black),
            onTap: () {
              // Handle item 2 tap
            },
          ),
          ListTile(
            title: AppFonts.normal('Logout', Colors.red),
            onTap: () {
              // Handle item 3 tap
            },
          ),
          //
        ],
      ),
    );
  }
}
