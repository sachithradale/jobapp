import 'package:flutter/material.dart';
import 'colors.dart';

class Button{
  //button style for the primary button
  static ElevatedButton primaryButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.blue[500],
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blue[400],
        backgroundColor: Colors.white, // Text color
        elevation: 5, // Elevation (shadow)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Button border radius
        ),
        side: BorderSide(
          color: Colors.blue[400]!, // Border color
          width: 2.0,
        ),
        padding: EdgeInsets.all(8.0), // Padding around the button
        minimumSize: Size(200, 45),
      ),
    );
  }

  //text button style for the secondary button
  static TextButton textButton(String text, Function() onPressed,double? size) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size??15,
          color: Colors.blue[500],
        ),
      ),
    );
  }

  //accept button style
  static ElevatedButton acceptButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[500],
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(120, 40),
      ),
    );
  }

  //reject button style
  static ElevatedButton rejectButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[200],
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(120, 40),
      ),
    );
  }

  static ElevatedButton formButtton(String text, Function() onPressed,double width) {
    return  ElevatedButton(
      onPressed:onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        )
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(width,40),
      ),
    );
  }
}