import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobapp/views/common/buttons.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../common/colors.dart';
import '../common/header.dart';
import '../common/textField.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class aboutMe extends StatefulWidget {
  aboutMe({super.key,required this.isEditable});
  bool isEditable = false;

  @override
  State<aboutMe> createState() => _aboutMeState();
}

class _aboutMeState extends State<aboutMe> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  Map<String,dynamic> userDetails = {};
  List<String> links = ['LinkedIn','Github','Portfolio'];
  List<int> fileBytes = <int>[];
  String? selectedfileName;
  List<dynamic> socialLinks=[];
  var token;
  var userId;

  @override
  void initState(){
    getSharedPrefData();
    getUserDetails();
    super.initState();
  }

  Future<void> getSharedPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fileBytes=prefs.getString('profilePic')!=null?base64Decode(prefs.getString('profilePic')!):[];
    });
  }

  Future<void> getUserDetails() async {
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
      final responseData = jsonDecode(response.body);
      print("Uset get Success");
      print(responseData);
      print(responseData['data']['profile']['socialLinks']);
      userDetails={
        'name':responseData['data']['profile']['name'],
        'dob':responseData['data']['profile']['dob'],
        'email':responseData['data']['email'],
        'phone':responseData['data']['profile']['phone'],
        'links':responseData['data']['profile']['socialLinks'],
        'qualification':responseData['data']['profile']['qualification'],
        'workExperience':responseData['data']['profile']['experience'],
        'education':responseData['data']['profile']['education'],
      };
      userDetails['links'].forEach((element) {
        socialLinks.add(element.toString());
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      nameController.text = userDetails['name'];
      dobController.text = userDetails['dob']!=null?userDetails['dob']:'1990-01-01';
      emailController.text = userDetails['email'];
      phoneController.text = userDetails['phone']!=null?userDetails['phone']:prefs.getString('contact');
      fileBytes = prefs.getString('profilePic')!=null?base64Decode(prefs.getString('profilePic')!):[];
    } else {
      print('Failed to load user details');
    }
  }

  Future<void> updateUserDetails() async{
    if(phoneController.text.isEmpty){
      showError("Please enter a Contact Number");
    }
    if(linkController.text.isNotEmpty){
      socialLinks.add(linkController.text);
    }

    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/users/update/$userId');
    print("Token is: $token");
    final data = jsonEncode({
        'name': nameController.text,
        'dob': dobController.text,
        'contact': phoneController.text,
        'socialLinks': socialLinks,
    });
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-access-token': '$token',
      },
      body: data,
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('contact', phoneController.text);
      setState(() {
        widget.isEditable = false;
      });
      linkController.clear();
      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Success',
                  style: TextStyle(
                    color: Colors.green
                  )
              ),
              content: AppFonts.customizeText('User Details Updated Successfully', AppColor.textColor, 14, FontWeight.normal),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
      );
    } else {
      showError('Failed to update user details');
      print('Failed to update user details');
    }
  }

  Future<void> pickFile(StateSetter setState) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.single;
      // print("File Type: " + file.extension.toString());
      try {
        File pickedFile = File(file.path!);
        fileBytes = await pickedFile.readAsBytes();
        setState(() {
          selectedfileName = file.name;
        });
      } catch (e) {
        print("Error reading file: $e");
      }
    } else {
      print("File picking canceled");
    }
  }

  Future<void> uploadImage() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String image = base64Encode(fileBytes);
     prefs.setString('profilePic', base64Encode(fileBytes));
     final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/users/update/image/$userId');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': '$token',
        },
        body: jsonEncode({
          'image': image,
        }),
      );
      if(response.statusCode == 200){
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                    'Success',
                    style: TextStyle(
                      color: Colors.green
                    )
                ),
                content: AppFonts.customizeText('Profile Picture Updated Successfully', AppColor.textColor, 14, FontWeight.normal),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              );
            },
        );
      }else{
        showError('Failed to update profile picture');
        print('Failed to update profile picture');
      }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, '/profile');
          return Future.value(false);
        },
        child: Scaffold(
            appBar: customizedAppBar(title: '').header(context),
            body: SingleChildScrollView(
                child:Column(
                  children: [
                    Center(child: AppFonts.heading('About me', null)),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: fileBytes.isEmpty?AssetImage('assets/images/img.png'):Image.memory(Uint8List.fromList(fileBytes)).image,
                        ),
                        IconButton(
                          onPressed: (){
                            pickFile(setState);
                          },
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                        Container(
                          width:150,
                          child: ElevatedButton(
                            onPressed: () {
                              uploadImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppFonts.customizeText('Upload Image', AppColor.primaryColor, 12, FontWeight.normal),
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
                      ],
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFields.textFieldWithLabel('John Fernando','Full Name',false, nameController,!widget.isEditable)
                    ),
                    SizedBox(height: 20,),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFields.textFieldWithLabel('1990-01-01','Date of Birth',false, dobController,!widget.isEditable)
                    ),
                    SizedBox(height: 20,),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFields.textFieldWithLabel('abc@gmail.com','Email',false, emailController,true)
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
                                    width: MediaQuery.of(context).size.width * 0.15,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AppFonts.customizeText('+94', AppColor.textColor, 15, FontWeight.bold),
                                    )),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: TextFormField(
                                    readOnly: !widget.isEditable,
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: widget.isEditable?BorderSide(color: AppColor.success, width: 2.0):BorderSide(color: AppColor.textColor, width: 1.0),
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
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFonts.customizeText('Links', AppColor.textColor, 12, FontWeight.bold),
                            socialLinks!=null?Column(
                              children: [
                                for(var link in socialLinks)
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: TextFields.textFieldWithLabel(link,'',false,TextEditingController(),true),
                                  ),
                              ],
                            ):Container(),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFields.textFieldWithLabel('Add New Link','',false,linkController,!widget.isEditable),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    widget.isEditable?Button.formButtton('Save',
                            () => {
                          setState(() {
                            updateUserDetails();
                          })
                        }, MediaQuery.of(context).size.width * 0.8):
                    Button.formButtton('Edit',
                            () => {
                          setState(() {
                            widget.isEditable = true;
                          })
                        }, MediaQuery.of(context).size.width * 0.8),
                    SizedBox(height: 40,)
                  ],
                )
            )
        )
    );
  }

  getUsername() {
    SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;
    return prefs.getString('token');
  }

  getUserId() {
    SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;
    return prefs.getString('id');
  }

  void showError(String error) {
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
          content: AppFonts.customizeText(error, AppColor.textColor, 14, FontWeight.normal),
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
