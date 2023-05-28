import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';

class AppFonts {
  static const circularStd = 'CircularStd';
}

class AppThemings {
  static final basicTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    textTheme:
        ThemeData.light().textTheme.apply(fontFamily: AppFonts.circularStd),
    primaryTextTheme:
        ThemeData.light().textTheme.apply(fontFamily: AppFonts.circularStd),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: AppFonts.circularStd,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );

  static final themeData =
      Get.isDarkMode ? ThemeData.dark() : ThemeData.light();
}
