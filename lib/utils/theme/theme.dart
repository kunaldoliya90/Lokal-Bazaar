import 'package:ecomapp/utils/theme/custom_themes/appbar_theme.dart';
import 'package:ecomapp/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:ecomapp/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:ecomapp/utils/theme/custom_themes/chip_theme.dart';
import 'package:ecomapp/utils/theme/custom_themes/elevatedbuttontheme.dart';
import 'package:ecomapp/utils/theme/custom_themes/outline_button_theme.dart';
import 'package:ecomapp/utils/theme/custom_themes/text_field_theme.dart';
import 'package:ecomapp/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.LightElevatedButtonTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.LightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: TOutlinedButton.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.DarkElevatedButtonTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.DarkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: TOutlinedButton.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme
  );
}