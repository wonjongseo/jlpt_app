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

  // static const TextStyle darkText = TextStyle(
  //   color: AppColors.black,
  //   fontFamily: AppFonts.circularStd,
  // );

  // static const TextStyle lightText = TextStyle(
  //   color: AppColors.black,
  //   fontFamily: AppFonts.circularStd,
  // );

  // static final IconThemeData darkIcon = IconThemeData(
  //   color: AppColors.whiteGrey,
  // );

  // static final IconThemeData lightIcon = IconThemeData(
  //   color: AppColors.black,
  // );

  // static final ThemeData darkTheme = themeData.copyWith(
  //   backgroundColor: AppColors.black,
  //   brightness: Brightness.dark,
  //   primaryColor: AppColors.blue,
  //   appBarTheme: AppBarTheme(
  //       backgroundColor: Colors.transparent,
  //       centerTitle: true,
  //       elevation: 0,
  //       toolbarTextStyle: darkText,
  //       titleTextStyle:
  //           darkText.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
  //       iconTheme: darkIcon,
  //       color: AppColors.black),
  //   textTheme: const TextTheme(
  //     displayLarge: darkText,
  //     displayMedium: darkText,
  //     displaySmall: darkText,
  //     headlineMedium: darkText,
  //     headlineSmall: darkText,
  //     titleLarge: darkText,
  //     titleMedium: darkText,
  //     titleSmall: darkText,
  //     bodyLarge: darkText,
  //     bodyMedium: darkText,
  //     bodySmall: darkText,
  //     labelLarge: darkText,
  //     labelSmall: darkText,
  //   ),
  //   scaffoldBackgroundColor: AppColors.black,
  // );

  // static final ThemeData lightTheme = themeData.copyWith(
  //   backgroundColor: AppColors.whiteGrey,
  //   brightness: Brightness.light,
  //   primaryColor: AppColors.blue,
  //   appBarTheme: AppBarTheme(
  //     centerTitle: true,
  //     elevation: 0,
  //     toolbarTextStyle: lightText,
  //     titleTextStyle:
  //         darkText.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
  //     iconTheme: lightIcon,
  //     backgroundColor: Colors.transparent,
  //   ),
  //   textTheme: const TextTheme(
  //     displayLarge: lightText,
  //     displayMedium: lightText,
  //     displaySmall: lightText,
  //     headlineMedium: lightText,
  //     headlineSmall: lightText,
  //     titleLarge: lightText,
  //     titleMedium: lightText,
  //     titleSmall: lightText,
  //     bodyLarge: lightText,
  //     bodyMedium: lightText,
  //     bodySmall: lightText,
  //     labelLarge: lightText,
  //     labelSmall: lightText,
  //   ),
  //   scaffoldBackgroundColor: AppColors.lightGrey,
  // );
}
