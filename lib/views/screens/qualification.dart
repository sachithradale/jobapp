import 'package:flutter/material.dart';

import '../../utils/date.dart';
import '../common/buttons.dart';
import '../common/colors.dart';
import '../common/fonts.dart';
import '../common/header.dart';
import '../common/textField.dart';

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
