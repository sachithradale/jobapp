import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobapp/views/common/buttons.dart';
import 'package:jobapp/views/common/fonts.dart';

import '../common/colors.dart';
import '../common/header.dart';
import '../common/textField.dart';

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

  Map<String,dynamic> userDetails = {
    'name':'John Fernando',
    'dob':'1990-01-01',
    'email':'john@gmail.com',
    'phone':'458569523'
  };
  List<String> links = ['LinkedIn','Github','Portfolio'];

  @override
  void initState() {
    nameController.text = userDetails['name'];
    dobController.text = userDetails['dob'];
    emailController.text = userDetails['email'];
    phoneController.text = userDetails['phone'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customizedAppBar(title: '').header(context),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Center(child: AppFonts.heading('About me', null)),
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/welcome.jpg'),
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
                child: TextFields.textFieldWithLabel('abc@gmail.com','Email',false, emailController,!widget.isEditable)
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
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: links.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: TextFormField(
                            readOnly: !widget.isEditable,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.success, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: links[index],
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            obscureText: false,
                          )
                        );
                      },
                    ),
                  ],
                )
            ),
            SizedBox(height: 20,),
            widget.isEditable?Button.formButtton('Save',
            () => {
              setState(() {
                widget.isEditable = false;
                //Todo: Save the details
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
    );
  }
}
