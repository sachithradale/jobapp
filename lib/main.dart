import 'package:flutter/material.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:jobapp/views/screens/aboutMe.dart';
import 'package:jobapp/views/screens/index.dart';
import 'package:jobapp/views/screens/login.dart';
import 'package:jobapp/views/screens/profile.dart';
import 'package:jobapp/views/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreenPage(),
      routes: {
        '/login': (context) =>  LoginPage(),
        '/signup': (context) =>  register(),
        '/profile': (context) =>  profile(),
        '/aboutMe': (context) =>  aboutMe(),
      }
    );
  }
}
