import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/textField.dart';

class register extends StatefulWidget {
  const register({super.key, required this.role});
  final String role;

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppFonts.heading('Create an Account', AppColor.primaryColor),
              SizedBox(height: 40,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFields.textField('Name', Icons.person, false, nameController)
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFields.textField('Email', Icons.email, false, emailController)
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFields.textField('Password', Icons.lock, true, passwordController)
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFields.textField('Confirm Password', Icons.lock, true, passwordController)
              ),
              SizedBox(height: 20,),
              Button.formButtton('Sign Up',
                      () {
                      //ToDo:Register function here
                        Navigator.pushNamed(context, '/login');
                  }
                  , MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFonts.customizeText('Already a Member?',AppColor.textColor, 12, FontWeight.normal),
                  Button.textButton('Login',
                          () {
                        Navigator.pushNamed(context, '/login');
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
