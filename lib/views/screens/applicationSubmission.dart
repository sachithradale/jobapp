import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jobapp/views/screens/JobView/home_screen.dart';
import '../common/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class applicationSubmission extends StatefulWidget {
  applicationSubmission({super.key, required this.companyName, required this.location, required this.job});
  final companyName;
  final location;
  final job;

  @override
  State<applicationSubmission> createState() => _applicationSubmissionState();
}

class _applicationSubmissionState extends State<applicationSubmission> {
  var token;
  var userId;
  String? selectedfileName;
  var filePath;
  List<int> fileBytes = <int>[];
  TextEditingController messageController = TextEditingController();

  Future<void> submitCV() async {
    String file = base64Encode(fileBytes); // Assuming fileBytes is defined and contains the file data
    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/application/create'); // Removed extra forward slash
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');
    String base64file = base64Encode(fileBytes);
    var data = {
      "job": widget.job.toString(),
      "applicant": userId.toString(),
      "resume": base64file,
      "description": messageController.text,
      "status": 'pending'
    };
    print(data);
    final response = await http.post(
      url,
      headers: {
        'x-access-token': token,
        'Content-Type': 'application/json'
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Success',
                style: TextStyle(
                    color: Colors.green
                )
            ),
            content: Text('Application Submitted Successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>HomeScreen()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      print(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error submitting application'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
          filePath = file.path;
          selectedfileName = file.name;
        });
      } catch (e) {
        print("Error reading file: $e");
      }
    } else {
      print("File picking canceled");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customizedAppBar(title: '').header(context),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppFonts.title(widget.companyName, Colors.black),
                SizedBox(height: 10,),
                AppFonts.subtitle(widget.location, Colors.black),
                SizedBox(height: 30,),
                AppFonts.customizeText('CV', Colors.black, 14, FontWeight.bold),
                Container(
                    padding: EdgeInsets.all(20), //padding of outer Container
                    child: DottedBorder(
                      color: Colors.black,//color of dotted/dash line
                      strokeWidth: 3, //thickness of dash/dots
                      dashPattern: [10,5],
                      child: Container(
                          height:100,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppFonts.customizeText('Upload Your CV', Colors.black, 14, FontWeight.normal),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        pickFile(setState);
                                      },
                                      icon: Icon(Icons.upload_file)
                                  ),
                                  SizedBox(width: 20,),
                                  AppFonts.customizeText('Choose File', Colors.black, 14, FontWeight.normal),
                                ],
                              ),
                              selectedfileName != null ? AppFonts.customizeText(selectedfileName!, Colors.green, 14, FontWeight.normal) : Text(''),
                            ],
                          )
                      ),
                    )
                ),
                SizedBox(height: 20,),
                AppFonts.customizeText('Message', Colors.black, 14, FontWeight.bold),
                TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20,),
                Button.formButtton('Submit', (){
                   submitCV();
                }, MediaQuery.of(context).size.width * 0.8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
