import 'package:flutter/material.dart';

import '../../utils/date.dart';
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/header.dart';
import '../common/textField.dart';

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
                      child: TextFields.textFieldWithLabel('Harvard University','School',false,schoolController,false)
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
                        //Todo: Save to database
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
