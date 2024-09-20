import 'package:divmeds/designs/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  hintColor: AppColors.accentColor,
  scaffoldBackgroundColor: AppColors.scaffoldBackGroundColorLightMode,
  
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.scaffoldBackGroundColorDarkMode,
  
);
