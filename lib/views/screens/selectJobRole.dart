import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/views/common/colors.dart';
import 'package:jobapp/views/common/fonts.dart';

import '../common/header.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      body:Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            AppFonts.title("Select Your Job Role", Colors.black),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signupEmployer');
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/employer.jpg'),
                  ),
                ),
                AppFonts.subtitle('Employer', Colors.black),
              ],
            ),
            SizedBox(height: 40,),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signupApplicant');
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/jobApplicant.jpg'),
                  ),
                ),
                AppFonts.subtitle('Job Applicant', Colors.black),
              ],
            ),
            SizedBox(height: 60,),
            AppFonts.customizeText("SimplyHired", AppColor.primaryColor, 25, FontWeight.bold),
            Image(image:
                AssetImage('assets/images/welcome.jpg',),
                width: 100,
                height: 50,
            ),
            AppFonts.subtitle('Connecting Dreams and Opportunities',null),
            AppFonts.normal('Where Aspirations Meet Careers',null),
          ],
        ),
      )
    );
  }
}
