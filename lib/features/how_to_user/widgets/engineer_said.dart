import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/string.dart';

class EngineerSaid extends StatelessWidget {
  const EngineerSaid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Responsive.height10),
          Text(
            AppString.howToUseMsg1.tr,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.scaffoldBackground),
          ),
          SizedBox(height: Responsive.height20),
          Text.rich(
            TextSpan(
              style: TextStyle(
                  height: 1.6,
                  wordSpacing: 1.2,
                  color: AppColors.scaffoldBackground),
              children: [
                TextSpan(
                  text: AppString.howToUseMsg2.tr,
                ),
                TextSpan(
                  text: AppString.howToUseMsg3.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: AppString.howToUseMsg4.tr,
                ),
                TextSpan(
                  text: AppString.howToUseMsg5.tr,
                ),
                TextSpan(
                  text: AppString.howToUseMsg6.tr,
                ),
                TextSpan(
                  text: AppString.howToUseMsg7.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: AppString.howToUseMsg8.tr,
                ),
                TextSpan(text: AppString.howToUseMsg9.tr),
                TextSpan(
                  text: AppString.howToUseMsg10.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg11.tr),
                TextSpan(
                  text: AppString.howToUseMsg12.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg13.tr),
                TextSpan(text: AppString.howToUseMsg14.tr),
                TextSpan(
                  text: AppString.howToUseMsg15.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg16.tr),
                TextSpan(text: AppString.howToUseMsg17.tr),
                TextSpan(
                  text: AppString.howToUseMsg18.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg19.tr),
                TextSpan(
                  text: AppString.howToUseMsg20.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg21.tr),
                TextSpan(text: AppString.howToUseMsg22.tr),
                TextSpan(
                  text: AppString.howToUseMsg23.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg24.tr),
                TextSpan(
                  text: AppString.howToUseMsg25.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg26.tr),
                TextSpan(text: AppString.howToUseMsg27.tr),
                TextSpan(
                  text: AppString.howToUseMsg28.tr,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: AppString.howToUseMsg29.tr),
                TextSpan(
                  text: AppString.howToUseMsg30.tr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
