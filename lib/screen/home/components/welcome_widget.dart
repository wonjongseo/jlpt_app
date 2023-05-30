import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';

import '../../../common/widget/heart_count.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    this.settingKey,
  });

  final GlobalKey? settingKey;

  @override
  Widget build(BuildContext context) {
    // UserController userController = Get.find<UserController>();

    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.18,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 16),
        child: FadeInDown(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('こんにちは！',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 22)),
                  Row(
                    children: [
                      Text(
                        'ようこそ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      Text(' JLPT 종각 APP',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24)),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const HeartCount(),
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
      ),
    );
  }
}
