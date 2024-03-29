import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserId(context); // Pass the context here
  }

  Future<void> _checkUserId(BuildContext context) async { // Add context here
    final prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');




    if (user != null) {
      final data = json.decode(user);
      var userRole = data['role'];
      if(userRole == 'employer') {
        Navigator.pushNamed(context, '/employerHome');
      } else {
        Navigator.pushNamed(context, '/jonApplicantHome');
      }
    } else {
      Navigator.pushNamed(context, '/login');
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
