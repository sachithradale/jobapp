import 'package:flutter/material.dart';
import 'package:jobapp/views/common/colors.dart';
import 'package:jobapp/views/common/fonts.dart';

class TextFields{
  static TextFormField textField(String hintText, IconData icon, bool obscureText,TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.success, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: obscureText,
    );
  }

  static Column textFieldWithLabel(String hintText, String heading, bool obscureText,TextEditingController controller, bool readOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFonts.customizeText(heading, AppColor.textColor, 12, FontWeight.bold),
        TextFormField(
          readOnly:readOnly ,
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: !readOnly?BorderSide(color: AppColor.success, width: 2.0):BorderSide(color: AppColor.textColor, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textColor, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: obscureText,
        ),
      ],
    );
  }
}