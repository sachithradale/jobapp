import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class customizedAppBar{
  customizedAppBar({required this.title});
  String title;
  AppBar header(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blueAccent,
      title: AppFonts.subtitle(
          title,
          Colors.white,
      ),
    );
  }
}

class CustomizedEmployeeDrawer extends StatelessWidget {
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
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: AppFonts.normal('Home', Colors.black),
            onTap: () {
              Navigator.pushNamed(context, '/employerHome');
            },
          ),
          ListTile(
            title: AppFonts.normal('Profile', Colors.black),
            onTap: () {
               Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: AppFonts.normal('Logout', Colors.red),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('userRole');
              Navigator.pushNamed(context, '/login');
            },
          ),
          //
        ],
      ),
    );
  }
}

class CustomizedAppplicantDrawer extends StatelessWidget {
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
              Navigator.pushNamed(context, '/applicantHome');
            },
          ),
          ListTile(
            title: AppFonts.normal('Saved Jobs', Colors.black),
            onTap: () {
              Navigator.pushNamed(context, '/savedJobs');
            },
          ),
          ListTile(
            title: AppFonts.normal('Profile', Colors.black),
            onTap: () {
               Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: AppFonts.normal('Logout', Colors.red),
            onTap: () async {
              //Todo: Add logout functionality
              //set shared preference to null
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('userRole');
              Navigator.pushNamed(context, '/login');
            },
          ),
          //
        ],
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
