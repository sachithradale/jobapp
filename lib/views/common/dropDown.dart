import 'package:flutter/material.dart';
import 'package:jobapp/views/common/fonts.dart';

class dropDown{
static Widget customizeDropDown(String hint, List<String> items, String value, Function(String?)? onChanged){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFonts.customizeText(hint, Colors.black, 14, FontWeight.bold),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            //border color
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[400]!, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}