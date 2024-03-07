import 'package:flutter/material.dart';
import '../screens/login.dart';
import 'package:jobapp/views/common/fonts.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    // Add a delay using Future.delayed
    Future.delayed(Duration(seconds: 5), () {
      // Navigate to the login page after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your background color
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppFonts.subtitle('Connecting Dreams and Opportunities',null),
          AppFonts.normal('Where Aspirations Meet Careers',null),
          Center(
            child: Container(
                width: 300,
                height: 300,
                child: Image.asset('assets/images/welcome.jpg')), // Replace with your image asset
          ),
        ],
      ),
    );
  }
}
