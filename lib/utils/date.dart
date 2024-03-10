import 'package:flutter/material.dart';
class Dates{
  static  selectDate(BuildContext context,selectedDate) async {
    final DateTime? picked = await showDatePicker(
      //change color of datepicker
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.blue,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
              //inital date color

            ),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2025,3));

    if (picked != null && picked != selectedDate) {
      return picked;
    }
  }
}