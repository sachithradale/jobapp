import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserId();
  }

  Future<void> _checkUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');

    if (user != null) {
      final data = json.decode(user!);
      print(data);
      var userRole = data['role'];
      print(userRole);
      if(userRole == 'employer') {
        Navigator.pushNamed(context, '/employerHome');
      } else {
        Navigator.pushNamed(context, '/jonApplicantHome');
      }
    } else {
      // User ID doesn't exist, navigate to login screen
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Or any loading indicator
      ),
    );
  }
}
