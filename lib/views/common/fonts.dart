import 'package:flutter/material.dart';

class AppFonts {
  static const String primaryFontFamily = 'poppins';

  static Text heading(String text, Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: color??Colors.black,
      ),
    );
  }

  static Text title(String text, Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: color??Colors.black,
      ),
    );
  }

  //text style for the sub title
  static Text subtitle(String text,Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: color??Colors.black,
      ),
    );
  }

  //text style for the normal text
  static Text normal(String text,Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: color??Colors.black,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  //customized text style for the text
  static Text customizeText(String text, Color color, double size, FontWeight weight) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: size,
        fontWeight: weight,
        color: color??Colors.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  //text style for the card titles
  static Text cardTitle(String text,Color? color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: color??Colors.black,
      ),
    );
  }

}
