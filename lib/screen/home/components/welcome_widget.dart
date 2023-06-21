import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';

import '../../../how_to_use_screen.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    this.settingKey,
    required this.isUserPremieum,
    this.welcomeKey,
  });

  final GlobalKey? welcomeKey;
  final GlobalKey? settingKey;
  final bool isUserPremieum;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Dimentions.height153,
      padding: EdgeInsets.only(
        top: Dimentions.height14,
        left: Dimentions.width22,
        right: Dimentions.width22,
      ),
      decoration: BoxDecoration(
          color: AppColors.whiteGrey,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimentions.height30),
            bottomRight: Radius.circular(Dimentions.height30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f0f0f0f),
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'こんにちは！',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.scaffoldBackground,
                      fontWeight: FontWeight.w800,
                      fontSize: isUserPremieum
                          ? Dimentions.width20
                          : Dimentions.width18,
                      fontFamily: AppFonts.japaneseFont,
                    ),
              ),
              SizedBox(height: Dimentions.height10 / 3),
              Row(
                children: [
                  Text(
                    'ようこそ ',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.scaffoldBackground,
                          fontWeight: FontWeight.w800,
                          fontSize: isUserPremieum
                              ? Dimentions.width20
                              : Dimentions.width18,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const HowToUseScreen());
                    },
                    child: FadeInDown(
                      child: Text(
                        key: welcomeKey,
                        isUserPremieum ? 'JLPT 종각 Plus' : 'JLPT 종각',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: isUserPremieum
                                  ? Dimentions.width24
                                  : Dimentions.width20,
                              fontFamily: AppFonts.nanumGothic,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                key: settingKey,
                onPressed: () => Get.toNamed(SETTING_PATH),
                icon: Icon(
                  Icons.settings,
                  size: Dimentions.width24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
