import 'package:flutter/material.dart';
import 'package:jobapp/views/common/colors.dart';
import 'package:jobapp/views/common/fonts.dart';

import '../common/buttons.dart';
import '../common/header.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      drawer: CustomizedDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/welcome.jpg'),
               ),
              SizedBox(height: 10,),
              AppFonts.normal('John Doe', AppColor.textColor),
              Container(
                width:150,
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppFonts.customizeText('Edit Details', AppColor.primaryColor, 12, FontWeight.normal),
                      SizedBox(width: 10,),
                      Icon(
                          Icons.edit,
                          size: 12,
                          color: AppColor.primaryColor,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    side: BorderSide(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child:ListTile(
                    leading: Icon(
                     Icons.person,
                     color: AppColor.textColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppFonts.subtitle('About me', Colors.black),
                        SizedBox(width: 10,),
                        IconButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/aboutMe');
                            },
                            icon: Icon(
                              Icons.navigate_next,
                              size: 20,
                              color: AppColor.textColor,
                            ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child:ListTile(
                    leading: Icon(
                      Icons.work,
                      color: AppColor.textColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppFonts.subtitle('Work experience', Colors.black),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: AppColor.textColor,
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child:ListTile(
                    leading: Icon(
                      Icons.school,
                      color: AppColor.textColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppFonts.subtitle('Education', Colors.black),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: AppColor.textColor,
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child:ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: AppColor.textColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppFonts.subtitle('Skill', Colors.black),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: AppColor.textColor,
                          ),
                        )
                      ],
                    )
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.textColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                child:ListTile(
                    leading: Icon(
                        Icons.book,
                        color:AppColor.textColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppFonts.subtitle('Qualifications', Colors.black),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: AppColor.textColor,
                          ),
                        )
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
