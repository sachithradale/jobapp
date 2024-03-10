import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';
import 'package:jobapp/views/common/header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../common/buttons.dart';

class applicationSubmission extends StatefulWidget {
  const applicationSubmission({super.key});

  @override
  State<applicationSubmission> createState() => _applicationSubmissionState();
}

class _applicationSubmissionState extends State<applicationSubmission> {
  Map<String,dynamic> data= {
    'position': 'Software Developer',
    'jobtype': 'Full Time',
    'workplace': 'On-Site',
    'location': 'CodeSphere-Colombo,Sri Lanka',
    'salaryLower': 5000,
    'salaryUpper': 15000
  };

  String? selectedfileName;
  List<int> fileBytes = <int>[];

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
                AppFonts.title(data['position'], Colors.black),
                SizedBox(height: 10,),
                AppFonts.subtitle(data['location'], Colors.black),
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
                  Navigator.pushNamed(context, '/profile');
                }, MediaQuery.of(context).size.width * 0.8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
