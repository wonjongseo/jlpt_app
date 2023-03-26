import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

BoxShadow cBoxShadow = BoxShadow(
  offset: const Offset(0, 3),
  blurRadius: 2,
  color: const Color(0xFF98DED9).withOpacity(0.25),
);

BoxDecoration cBoxDecoration = BoxDecoration(
    color: Get.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 1,
        offset: Offset(0, 1),
      )
    ],
    borderRadius: BorderRadius.circular(10));
