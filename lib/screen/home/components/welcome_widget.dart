import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    this.settingKey,
  });

  final GlobalKey? settingKey;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.18,
      padding: const EdgeInsets.only(top: 15, left: 22, right: 22),
      decoration: const BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: FadeInDown(
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
                        fontSize: 18,
                        fontFamily: AppFonts.japaneseFont,
                      ),
                ),
                Row(
                  children: [
                    Text(
                      'ようこそ',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: AppColors.scaffoldBackground,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                fontFamily: AppFonts.japaneseFont,
                              ),
                    ),
                    Text(
                      ' JLPT 종각 APP',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: AppFonts.nanumGothic,
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
                  icon: const Icon(
                    Icons.settings,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
