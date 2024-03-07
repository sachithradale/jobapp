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

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Handle item 2 tap
            },
          ),
          //
        ],
      ),
    );
  }
}
