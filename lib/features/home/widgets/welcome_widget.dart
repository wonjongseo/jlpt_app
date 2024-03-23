import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/home/services/home_controller.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Column(
      children: [
        Text(
          'Hello, Everyone',
          style: TextStyle(
            fontSize: Responsive.height22,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          homeController.userController.isUserPremieum()
              ? 'Welcome to JLPT종각+'
              : 'Welcome to JLPT종각',
          style: TextStyle(
              fontSize: Responsive.height25,
              fontWeight: FontWeight.w900,
              color: Colors.cyan.shade700),
        ),
      ],
    );
  }
}
