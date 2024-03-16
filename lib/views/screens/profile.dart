import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jobapp/views/common/colors.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/buttons.dart';
import '../common/header.dart';
import 'aboutMe.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  void initState(){
    getName();
    checkJobRole();
    setprofilepic();
    super.initState();
  }
  List<int> profilepic = [];
  var token;
  var userId;
  String name = 'John Doe';

  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');
    print('Token: $token');
    print('User ID: $userId');
    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/users/$userId');
    final response = await http.get(
      url,
      headers: <String, String>{
        'x-access-token': token,
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData);
      setState(() {
        name = responseData['data']['profile']['name'];
      });
    } else {
      print('Failed to load profile');
    }
  }

  Future<void> setprofilepic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('profilePic') == null){
      prefs.setString('profilePic', 'assets/images/img.png');
    }else{
      setState(() {
        setState(() {
          profilepic=prefs.getString('profilePic')!=null?base64Decode(prefs.getString('profilePic')!):[];
        });
      });
    }
  }

  String? userRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      drawer:userRole == 'employer' ? CustomizedEmployeeDrawer() : CustomizedAppplicantDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: profilepic.isEmpty ? AssetImage('assets/images/img.png') : Image.memory(Uint8List.fromList(profilepic)).image,
               ),
              SizedBox(height: 10,),
              AppFonts.normal(name, AppColor.textColor),
              Container(
                width:150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => aboutMe(isEditable: true)));
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
                          onPressed: (){
                            Navigator.pushNamed(context, '/workExperience');
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
                          onPressed: (){
                            Navigator.pushNamed(context, '/education');
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
                          onPressed: (){
                            Navigator.pushNamed(context, '/skills');
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
                          onPressed: (){
                            Navigator.pushNamed(context, '/qualification');
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkJobRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = prefs.getString('userRole');
      print(userRole);
    });
  }
}
