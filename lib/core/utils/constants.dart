import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class containing constants used throughout the app
class Constants {
  static const String DB_NAME = "app.db";
  static const String APP_NAME = "assignment";
  static const String AUTHORIZATION = "Authorization";
  static const String API_DATA = "lista";
  static const String ERROR_NO_INTERNET =
      "Please check your internet connection";
  static const String ERROR_UNKNOWN = "Unknown error occurred";
  static const String ERROR_TYPE_TIMEOUT = "Time Out";
}

class AppColors {
  static const Color white = Color(0xffffffff);
  static const Color whiteShade=Color(0xffF8F8F8);
  static const Color textFiledColor=Color(0xff2AAFE0);
  static const Color greenTwo=Color(0xff03CA32);

}

class FontConstants {

}

class AppFonts {
  /*static TextStyle headlineMediumStyle({
    double fontSize = 12.0,
    Color fontColor = Colors.white,
    bool isUnderline = false,
  }) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w500,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      letterSpacing: -0.10,
    );
  }

  static TextStyle headlineRegularStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.normal,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle headlineBoldStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false,
      Color backgroundColor = Colors.transparent}) {
    return _headlineFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.bold,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      backgroundColor: backgroundColor,
    );
  }

  static TextStyle headlineSemiBoldStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false}) {
    return _headlineFontStyle(
        fontSize: fontSize,
        fontColor: fontColor,
        fontWeight: FontWeight.w600,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        letterSpacing: -0.10);
  }

  static TextStyle lightStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false}) {
    return _normalFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w300,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle mediumStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false}) {
    return _normalFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w500,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle regularStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      bool isUnderline = false}) {
    return _normalFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.normal,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle semiBoldStyle({
    double fontSize = 12.0,
    Color fontColor = Colors.white,
    bool isUnderline = false,
  }) {
    return _normalFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.w600,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle boldStyle({
    double fontSize = 12.0,
    Color fontColor = Colors.white,
    bool isUnderline = false,
  }) {
    return _normalFontStyle(
      fontSize: fontSize,
      fontColor: fontColor,
      fontWeight: FontWeight.bold,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle _normalFontStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      FontWeight fontWeight = FontWeight.normal,
      TextDecoration decoration = TextDecoration.none}) {
    return TextStyle(
      fontFamily: FontConstants.FONT_HEADLINE,
      color: fontColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }

  static TextStyle _headlineFontStyle(
      {double fontSize = 12.0,
      Color fontColor = Colors.white,
      FontWeight fontWeight = FontWeight.normal,
      TextDecoration decoration = TextDecoration.none,
      double letterSpacing = -0.75,
      Color backgroundColor = Colors.transparent}) {
    final Paint paint = Paint();
    paint.color = backgroundColor;
    return TextStyle(
        fontFamily: FontConstants.FONT_HEADLINE,
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
        background: paint);
  }*/
}

class DBConstants {
  static const String TABLE_USER = "sign_up";
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String PASSWORD = "password";
  static const String NUMBER = "number";
  static const String IMAGE = "image";

}

class ImageConstants {
  static const String IMAGE =
      "assets/images/image.jpg";
}
