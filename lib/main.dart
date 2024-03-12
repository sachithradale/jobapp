import 'package:flutter/material.dart';
import 'package:jobapp/views/screens/JobView/home_screen.dart';
import 'package:jobapp/views/screens/JobView/job_detailed_view.dart';
import 'package:jobapp/views/screens/main_screen.dart';


import 'package:jobapp/views/common/header.dart';
import 'package:jobapp/views/screens/aboutMe.dart';
import 'package:jobapp/views/screens/applicationSubmission.dart';
import 'package:jobapp/views/screens/createJob.dart';
import 'package:jobapp/views/screens/education.dart';
import 'package:jobapp/views/screens/employerHome.dart';

import 'package:jobapp/views/screens/login.dart';
import 'package:jobapp/views/screens/profile.dart';
import 'package:jobapp/views/screens/qualification.dart';
import 'package:jobapp/views/screens/register.dart';

import 'package:provider/provider.dart';

import 'controllers/job_view.dart';



import 'package:jobapp/views/screens/skills.dart';
import 'package:jobapp/views/screens/workExperience.dart';

import 'controllers/jobs_provider.dart';


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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JobNotifier()),
      ],
      child: MaterialApp(
          title: 'Job App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: register(),
          routes: {
            '/login': (context) => LoginPage(),
            '/signup': (context) => register(),
            '/profile': (context) => profile(),
            '/aboutMe': (context) => aboutMe(isEditable: false,),
            '/workExperience': (context) => Experience(),
            '/education': (context) => Education(),
            '/skills': (context) => Skills(),
            '/qualification': (context) => Qualification(),
            '/employerHome': (context) => EmployerHome(),
            '/createJob': (context) => CreateJob(),
            '/jobApplication': (context) => applicationSubmission(),
            '/jobDetailedView': (context) => JobDetailView(),
            '/homeScreen': (context) => HomeScreen(),
          }
      ),
    );
  }
}



