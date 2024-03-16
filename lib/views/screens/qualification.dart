import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../utils/date.dart';
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/header.dart';
import '../common/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Qualification extends StatefulWidget {
  const Qualification({Key? key}) : super(key: key);

  @override
  _QualificationState createState() => _QualificationState();
}

class _QualificationState extends State<Qualification> {
  //qualification,date,description
  TextEditingController qualificationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var token;
  var userId;

  Future<void> saveQualification() async {
    print('Qualification: ${qualificationController.text}');
    print('Date: ${dateController.text}');
    print('Description: ${descriptionController.text}');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    userId = prefs.getString('id');

    final Uri url = Uri.parse('https://madbackend-production.up.railway.app/api/users/update/$userId');
    var data={
      "qualifications":[{
        "qualification": qualificationController.text,
        "date": selectedDate?.toIso8601String(),
        "description": descriptionController.text
      }]
    };
    final response = await http.patch(
      url,
      headers: {
        'x-access-token': token,
        'Content-Type': 'application/json'
      },
      body: jsonEncode(data),
    );
    if(response.statusCode==200){
      qualificationController.clear();
      dateController.clear();
      descriptionController.clear();

      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  'Success',
                  style: TextStyle(
                      color: Colors.green
                  )
              ),
              content: Text(
                  'Qualification added successfully',
                  style: TextStyle(
                      color: Colors.black
                  )
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                          'Close',
                          style: TextStyle(
                              color: Colors.blue
                          )
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Text(
                          'OK',
                          style: TextStyle(
                              color: Colors.blue
                          )
                      ),
                    ),
                  ],
                )
              ],
            );
          }
      );
    }else{
      print(response.statusCode);
      print('Failed to add qualification');
    }
  }

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      body: SingleChildScrollView(
          child:Column(
              children:[
                SizedBox(height: 20,),
                Center(child: AppFonts.heading('Add Qualification ', null)),
                SizedBox(height: 20,),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFields.textFieldWithLabel('Harvard University','Qualification',false,qualificationController,false)
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppFonts.customizeText('Date', AppColor.textColor, 12, FontWeight.bold),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          onTap: () async {
                            selectedDate = await Dates.selectDate(context, selectedDate ?? DateTime.now());
                            dateController.text = formatDate(selectedDate!);
                          },
                          readOnly: true,
                          controller: dateController,
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
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
                Button.formButtton('Save',
                        () => {
                     saveQualification()
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
}
