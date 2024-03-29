import 'package:flutter/material.dart';
import 'package:jobapp/views/screens/JobView/filter_view.dart';
import 'package:jobapp/views/screens/JobView/home_screen.dart';
import 'package:jobapp/views/screens/JobView/job_detailed_view.dart';
import 'package:jobapp/views/screens/applicantDetails.dart';
import 'package:jobapp/views/screens/appliedJobs.dart';
import 'package:jobapp/views/screens/index.dart';
import 'package:jobapp/views/screens/jobViews.dart';
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
import 'package:jobapp/views/screens/savedJobs.dart';
import 'package:jobapp/views/screens/selectJobRole.dart';
import 'package:jobapp/views/screens/splashLoadingScreen.dart';
import 'package:provider/provider.dart';
import 'controllers/job_view.dart';
import 'package:jobapp/views/screens/skills.dart';
import 'package:jobapp/views/screens/workExperience.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/jobs_provider.dart';
import 'controllers/saved_jobs_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
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
        ChangeNotifierProvider(create: (_) => JobProvider()),
      ],
      child: MaterialApp(
          title: 'Job App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: SplashScreen(),
          routes: {
            '/base': (context) => SplashScreen(),
            '/login': (context) =>  LoginPage(),
            '/register': (context) =>  Register(),
            '/main': (context) =>  MainScreen(),
            '/jobrole': (context) =>  SelectRole(),
            '/profile': (context) =>  profile(),
            '/aboutMe': (context) =>  aboutMe(isEditable: false,),
            '/workExperience': (context) =>  Experience(),
            '/education': (context) =>  Education(),
            '/skills': (context) =>  Skills(),
            '/qualification': (context) =>  Qualification(),
            '/jonApplicantHome': (context) =>  HomeScreen(),
            '/employerHome': (context) =>  EmployerHome(),
            '/createJob': (context) =>  CreateJob(),
            '/savedJobs': (context) =>  SavedJobs(),
            '/applicantHome': (context) =>  HomeScreen(),
            '/jobDetail': (context) =>  JobDetailView(),
            '/jobDetailedView': (context) => JobDetailView(),
            '/homeScreen': (context) => HomeScreen(),
            '/filterJob' :(context) => FilterPage(),
            '/appliedJobs': (context) => AppliedJobs(),
            '/jobViews': (context) => JobViews(),
          }
      ),
    );
  }
}


