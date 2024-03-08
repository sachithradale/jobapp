import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';

import '../common/colors.dart';
import '../common/header.dart';
import '../common/textField.dart';

class aboutMe extends StatefulWidget {
  const aboutMe({super.key});

  @override
  State<aboutMe> createState() => _aboutMeState();
}

class _aboutMeState extends State<aboutMe> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: AppFonts.heading('About me', null)),
            SizedBox(height: 40,),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textFieldWithLabel('John Fernando','Full Name',false, nameController)
            ),
            SizedBox(height: 20,),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textFieldWithLabel('1990-01-01','Date of Birth',false, dobController)
            ),
            SizedBox(height: 20,),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFields.textFieldWithLabel('abc@gmail.com','Email',false, emailController)
            ),
            SizedBox(height: 20,),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppFonts.customizeText('Phone Number', AppColor.textColor, 12, FontWeight.bold),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AppFonts.customizeText('+94', AppColor.textColor, 15, FontWeight.bold),
                            )),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.success, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: '458569523',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
}
