import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/calendar_step_sceen.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/admob/native_ad/native_ad_widget.dart';
import '../../../common/app_constant.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatelessWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;

  UserController userController = Get.find<UserController>();

  final String level;
  final bool isJlpt;

  BookStepScreen({super.key, required this.level, required this.isJlpt}) {
    if (isJlpt) {
      jlptWordController = Get.put(JlptStepController(level: level));
    } else {
      kangiController = Get.put(KangiStepController(level: level));
    }
  }

  void goTo(int index, String chapter) {
    if (isJlpt) {
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'isJlpt': true});
    } else {
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'isJlpt': false});
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TtsController());
    if (isJlpt) {
      return Scaffold(
        appBar: AppBar(
          title: Text('N$level급 단어'),
          actions: const [HeartCount()],
        ),
        body: ListView.separated(
          itemCount: jlptWordController.headTitleCount,
          separatorBuilder: (context, index) {
            if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
              return NativeAdWidget();
            }
            return Container();
          },
          itemBuilder: (context, index) {
            String chapter = '챕터${index + 1}';

            return FadeInLeft(
              delay: Duration(milliseconds: 200 * index),
              child:
                  BookCard(level: chapter, onTap: () => goTo(index, chapter)),
            );
          },
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text('N$level급 한자'),
        actions: const [HeartCount()],
      ),
      body: ListView.separated(
        itemCount: kangiController.headTitleCount,
        separatorBuilder: (context, index) {
          if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
            return NativeAdWidget();
          }
          return Container();
        },
        itemBuilder: (context, index) {
          String chapter = '챕터${index + 1}';

          return FadeInLeft(
            delay: Duration(milliseconds: 200 * index),
            child: BookCard(
              level: chapter,
              onTap: () => goTo(index, chapter),
            ),
          );
        },
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
