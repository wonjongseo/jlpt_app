import 'package:flutter/material.dart';
import 'package:japanese_voca/config/colors.dart';

class AppFonts {
  static const notoSansKR = 'NotoSerifKR';
  static const japaneseFont = 'NotoSerifJP';
}

class AppThemings {
  static TextStyle textStyle = const TextStyle(
      color: AppColors.whiteGrey, fontFamily: AppFonts.notoSansKR);

  static final dartTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    textTheme: ThemeData.light()
        .textTheme
        .apply(
          fontFamily: AppFonts.notoSansKR,
          bodyColor: Colors.white,
          displayColor: Colors.amber,
          decorationColor: Colors.white,
        )
        .copyWith(
          displayLarge: textStyle,
          displayMedium: textStyle,
          displaySmall: textStyle,
          headlineLarge: textStyle,
          headlineMedium: textStyle,
          headlineSmall: textStyle,
          titleLarge: textStyle,
          titleMedium: textStyle,
          titleSmall: textStyle,
          bodyLarge: textStyle,
          bodyMedium: textStyle,
          bodySmall: textStyle,
          labelLarge: textStyle,
          labelMedium: textStyle,
          labelSmall: textStyle,
        ),
    primaryTextTheme:
        ThemeData.light().textTheme.apply(fontFamily: AppFonts.notoSansKR),
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: AppFonts.notoSansKR,
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
}
