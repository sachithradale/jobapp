import 'package:flutter/material.dart';
import 'package:jobapp/views/common/colors.dart';

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
}