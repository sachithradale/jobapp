import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? _selectedRole;

  List<String> _roles = ['jobApplicant', 'employer'];

  Future<void> _register() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    // Check if passwords match
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Passwords do not match'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/auth/signup');
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'role': _selectedRole!,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      final Map<dynamic, dynamic> user = responseData['data'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user', json.encode(user));

      Navigator.pushNamed(context, '/base');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Registration failed: ${response.body}'),
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
              AppFonts.heading('Create an Account', AppColor.primaryColor),
              SizedBox(height: 40,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textField('Name', Icons.person, false, nameController),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textField('Email', Icons.email, false, emailController),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textField('Password', Icons.lock, true, passwordController),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textField('Confirm Password', Icons.lock, true, confirmPasswordController),
              ),
              SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButtonFormField<String>(
                  value: _selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  items: _roles.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Button.formButtton('Sign Up', _register, MediaQuery.of(context).size.width * 0.8),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFonts.customizeText('Already a Member?', AppColor.textColor, 12, FontWeight.normal),
                  Button.textButton(
                    'Login',
                        () {
                      Navigator.pushNamed(context, '/login');
                    },
                    12,
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
