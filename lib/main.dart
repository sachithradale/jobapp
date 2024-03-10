import 'package:flutter/material.dart';
import 'package:jobapp/views/screens/main_screen.dart';

import 'package:jobapp/views/screens/login.dart';
import 'package:jobapp/views/screens/register.dart';
import 'package:provider/provider.dart';

import 'controllers/job_view.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationController(),
      child: MyApp(),
    ),
  );
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
      home: MainScreen(),
      routes: {
        '/login': (context) =>  LoginPage(),
        '/signup': (context) =>  register()
      }
    );
  }
}


