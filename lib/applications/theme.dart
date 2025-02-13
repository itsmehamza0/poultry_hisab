import 'package:flutter/material.dart';
import 'package:poultry_hisab/applications/color.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
    backgroundColor: AppColors.appMainColor,
    foregroundColor: Colors.white,
  ));
}
