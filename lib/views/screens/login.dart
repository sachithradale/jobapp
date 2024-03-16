import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/textField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/auth/signin');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Login successful
      final responseData = json.decode(response.body);

      var userRole = responseData['data']['role'];
      print("User Role: $userRole");
      var token= responseData['data']['token'];
      print("Token: $token");
      var userId=responseData['data']['id'];

      // Save token to shared preferences
      final Map<dynamic, dynamic> user = responseData['data'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString('userRole',userRole);
      prefs.setString('user', json.encode(user));
      prefs.setString('id', userId);

      emailController.clear();
      passwordController.clear();

      if(userRole == 'employer') {
        Navigator.pushNamed(context, '/employerHome');
      } else {
        Navigator.pushNamed(context, '/jonApplicantHome');
      }
    } else {
      // Login failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Error',
                style: TextStyle(
                  color: Colors.red
                )
            ),
            content: Text("Username and password does not match"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppFonts.heading('Welcome Back!', AppColor.primaryColor),
              SizedBox(height: 20,),
              AppFonts.subtitle('Login to continue', AppColor.textColor),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textField('Email', Icons.email, false, emailController),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textField('Password', Icons.lock, true, passwordController),
              ),
              SizedBox(height: 20,),
              Button.formButtton('Login', _login, MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFonts.customizeText('Don''t have an account?', AppColor.textColor, 12, FontWeight.normal),
                  Button.textButton(
                      'Sign Up',
                          () {
                        Navigator.pushNamed(context, '/register');
                      },
                      12
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
