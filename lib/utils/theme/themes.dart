import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'AvenirNextRoundedPro',
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    appBarTheme: appBarTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    hintStyle: TextStyle(
      color: AppColors.kLightTextColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 2,
    ),
    labelStyle: TextStyle(
      color: AppColors.kTextColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: AppColors.kPrimaryColor,
    elevation: 0,
    brightness: Brightness.light,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    centerTitle: true,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(
      color: AppColors.kTextColor,
    ),
    bodyText2: TextStyle(
      color: AppColors.kTextColor,
    ),
  );
}
