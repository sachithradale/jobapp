import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:jobapp/views/common/colors.dart';
import 'package:jobapp/views/common/textField.dart';

import '../common/buttons.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customizedAppBar(title: 'Welcome').header(context),
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
                  child: TextFields.textField('Email', Icons.email, false, emailController)
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFields.textField('Password', Icons.lock, true, passwordController)
              ),
              SizedBox(height: 20,),
              Button.formButtton('Login',
                      () =>{
                        Navigator.pushNamed(context, '/profile')
                      }, MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 10,),
              Button.formButtton('Employee Login',
                      () =>{
                    Navigator.pushNamed(context, '/employerHome')
                  }, MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              Button.formButtton('job Application',
                      () =>{
                    Navigator.pushNamed(context, '/jobApplication')
                  }, MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFonts.customizeText('Don''t have an account?',AppColor.textColor, 12, FontWeight.normal),
                  Button.textButton('Sign Up',
                          () {
                            Navigator.pushNamed(context, '/signup');
                          },12
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
