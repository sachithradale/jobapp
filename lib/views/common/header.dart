import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  var token;
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
            title: AppFonts.normal('Job Interests', Colors.black),
            onTap: () {
              Navigator.pushNamed(context, '/jobViews');
            },
          ),
          ListTile(
            title: AppFonts.normal('Logout', Colors.red),
            onTap: () async {
              //clear shared preference
              SharedPreferences prefs = await SharedPreferences.getInstance();
              token = prefs.getString('token');
              final Uri uri = Uri.parse('https://madbackend-production.up.railway.app/api/auth/signout');
              var response = await http.delete(
                  uri,
                  headers: {
                    'x-access-token': token
                  }
              );
              if(response.statusCode == 200) {
                //clear all shared preference
                await prefs.clear();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushNamed(context, '/login');
              }else{
                print('Error');
                print(response.statusCode);
                showDialog(context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                            'Error',
                            style: TextStyle(
                                color: Colors.red
                            )
                        ),
                        content: Text(
                            'An error occured while logging out',
                            style: TextStyle(
                                color: Colors.black
                            )
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                'Close',
                                style: TextStyle(
                                    color: Colors.blue
                                )
                            ),
                          )
                        ],
                      );
                    }
                );
              }
            },
          ),
          //
        ],
      ),
    );
  }
}

class CustomizedAppplicantDrawer extends StatelessWidget {
  var token;
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
            title: AppFonts.normal('Applied Jobs', Colors.black),
            onTap: () {
              Navigator.pushNamed(context, '/appliedJobs');
            },
          ),
          ListTile(
            title: AppFonts.normal('Logout', Colors.red),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              token=prefs.getString('token');
              final Uri uri = Uri.parse('https://madbackend-production.up.railway.app/api/auth/signout');
              var response = await http.delete(
                uri,
                headers: {
                  'x-access-token': token
                }
              );
              if(response.statusCode == 200) {
                await prefs.clear();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushNamed(context, '/login');
              }else{
                showDialog(context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Error',
                          style: TextStyle(
                            color: Colors.red
                          )
                        ),
                        content: Text(
                          'An error occured while logging out',
                          style: TextStyle(
                            color: Colors.black
                          )
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: Colors.blue
                              )
                            ),
                          )
                        ],
                      );
                    }
                );
              }
            },
          ),
          //
        ],
      ),
    );
  }
}
