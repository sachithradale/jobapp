import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/date.dart';
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/header.dart';
import '../common/textField.dart';
import 'package:http/http.dart' as http;

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  //school,degree,field of study,startdate,enddate,description
  TextEditingController schoolController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  bool? checkBoxValue;
  var token;
  var userId;

  Future<void> uploadEducation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');
    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/users/update/$userId');
    var data={
      "education": [{
        "institution": schoolController.text,
        "degree": degreeController.text,
        "field": fieldOfStudyController.text,
        "startDate": selectedStartDate?.toIso8601String(),
        "endDate": selectedEndDate?.toIso8601String(),
        "description": descriptionController.text,
      }]
    };
    print(data);
    var response = await http.patch(
        url,
        headers:{
          'x-access-token': token,
        },
        body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      print('Work Experience Added');
      //clear the fields
      schoolController.clear();
      degreeController.clear();
      fieldOfStudyController.clear();
      startDateController.clear();
      endDateController.clear();
      descriptionController.clear();
      checkBoxValue = false;
      showDialog(context: context,
          builder:
              (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Success',
                  style: TextStyle(
                      color: Colors.green
                  )
              ),
              content: AppFonts.customizeText('Education Details Added Successfully', AppColor.textColor, 14, FontWeight.normal),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                  child: Text('OK'),
                ),
              ],
            );
          }
      );
    } else {
      showError('Failed to add Education Details', context);
      print('Failed to add work experience');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customizedAppBar(title: '').header(context),
        body: SingleChildScrollView(
            child:Column(
                children:[
                  Center(child: AppFonts.heading('Add Education ', null)),
                  SizedBox(height: 20,),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFields.textFieldWithLabel('Harvard University','School/Institute',false,schoolController,false)
                  ),
                  SizedBox(height: 10,),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFields.textFieldWithLabel('Bachelors','Degree',false,degreeController,false)
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppFonts.customizeText('Start Date', AppColor.textColor, 12, FontWeight.bold),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: TextFormField(
                                onTap: () async {
                                  selectedStartDate = await Dates.selectDate(context, selectedStartDate!=null?selectedStartDate:DateTime.now());
                                  startDateController.text = formatDate(selectedStartDate!);
                                },
                                readOnly: true,
                                controller: startDateController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.success, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: '2021-01-01',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppFonts.customizeText('End Date', AppColor.textColor, 12, FontWeight.bold),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: TextFormField(
                                onTap: () async {
                                  selectedEndDate = await Dates.selectDate(context, selectedEndDate!=null?selectedEndDate:DateTime.now());
                                  endDateController.text = formatDate(selectedEndDate!);
                                },
                                readOnly: true,
                                controller: endDateController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.success, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: '2021-01-01',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            activeColor: AppColor.primaryColor,
                            value: checkBoxValue!=null?checkBoxValue:false,
                            onChanged: (bool? value) {
                              setState(() {
                                checkBoxValue = value;
                              });
                            }
                        ),
                        AppFonts.customizeText('I currently studied in here', AppColor.textColor, 12, FontWeight.normal),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppFonts.customizeText('Description', AppColor.textColor, 12, FontWeight.bold),
                        TextFormField(
                          maxLines: 5,
                          controller: descriptionController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.success, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Developed software for Google',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Button.formButtton('Save',
                          () => {
                        uploadEducation()
                      },
                      MediaQuery.of(context).size.width * 0.8),
                ]
            )
        )
    );
  }

  String formatDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }

  void showError(String s, BuildContext context) {
    showDialog(context: context,
        builder:
            (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Error',
                style: TextStyle(
                    color: Colors.red
                )
            ),
            content: AppFonts.customizeText(s, AppColor.textColor, 14, FontWeight.normal),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        }
    );
  }
}
