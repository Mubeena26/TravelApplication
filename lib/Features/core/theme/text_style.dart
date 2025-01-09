import 'package:flutter/material.dart';
import 'package:travelapp_project/Features/core/theme/utils_colors.dart';

class AppTextStyles {
  // Headline Styles
  static const TextStyle headline1 = TextStyle(
    color: whitecolor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle booking =
      TextStyle(color: whitecolor, fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle booking2 = TextStyle(color: whitecolor, fontSize: 16);
  static const TextStyle home = TextStyle(
    color: Color.fromARGB(255, 66, 88, 132),
    fontWeight: FontWeight.bold,
  );
//  Color.fromARGB(255, 66, 88, 132)
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Body Text Styles
  static const TextStyle body1 = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 25, color: lightPrimary);
  static const TextStyle body4 =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: lightPrimary);
  static const TextStyle body2 =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 48, color: lightPrimary);
  static const TextStyle body3 = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 10, color: lightPrimary);

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Button Text Style
  static const TextStyle button = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    // Buttons often have white text on colored backgrounds
  );
  // Button Text Style
  static const TextStyle button1 = TextStyle(
    fontSize: 14.0,
    color: grey,
    // Buttons often have white text on colored backgrounds
  );

  // Caption Text Style
  static const TextStyle caption = TextStyle(
    color: whitecolor,
  );
  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.bold,
  );

  static const chatCall = TextStyle(color: Colors.black);

  static const chatMessage = TextStyle(
    fontStyle: FontStyle.italic,
    color: grey,
  );
  static const chatMssag2 =
      TextStyle(color: blackcolor, fontWeight: FontWeight.bold);
}
