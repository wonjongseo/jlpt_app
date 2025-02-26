import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    int curHour = now.hour;
    String gretting = '';

    if (curHour > 1 && curHour < 13) {
      gretting = 'おはようございます';
    } else if (curHour >= 13 && curHour < 19) {
      gretting = 'こんにちは';
    } else {
      gretting = 'こんばんは';
    }

    return GetBuilder<UserController>(builder: (userController) {
      return Column(
        children: [
          Text(
            gretting,
            style: TextStyle(
              fontSize: Responsive.height22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.appName.tr,
                style: TextStyle(
                  fontSize: Responsive.height25,
                  fontWeight: FontWeight.w900,
                  color: AppColors.mainBordColor,
                ),
              ),
              if (userController.user.isPremieum)
                Text(
                  '+',
                  style: TextStyle(
                    fontSize: Responsive.height25,
                    fontWeight: FontWeight.w900,
                    color: Colors.redAccent,
                  ),
                ),
              Text(
                'へようこそ',
                style: TextStyle(
                  fontSize: Responsive.height25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
