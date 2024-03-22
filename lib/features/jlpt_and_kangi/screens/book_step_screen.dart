import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
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
      return GridView.builder(
        itemCount: jlptWordController.headTitleCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => goTo(index, '챕터${index + 1}'),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${(index + 1)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (index == 0)
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            color: AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(15)),
                      ),
                    )
                ],
              ),
            )),
          );
        },
      );
      // return ListView.separated(
      //   itemCount: jlptWordController.headTitleCount,
      //   separatorBuilder: (context, index) {
      //     // if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
      //     //   return NativeAdWidget();
      //     // }
      //     return Container();
      //   },
      //   itemBuilder: (context, index) {
      //     String chapter = '챕터${index + 1}';

      //     return FadeInLeft(
      //       delay: Duration(milliseconds: 200 * index),
      //       child: BookCard(
      //           level: (index + 1).toString(),
      //           onTap: () => goTo(index, chapter)),
      //     );
      //   },
      // );
      // return Scaffold(
      //   appBar: AppBar(
      //     title: Text('N$level급 단어'),
      //     actions: const [HeartCount()],
      //   ),
      //   body: ListView.separated(
      //     itemCount: jlptWordController.headTitleCount,
      //     separatorBuilder: (context, index) {
      //       if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
      //         return NativeAdWidget();
      //       }
      //       return Container();
      //     },
      //     itemBuilder: (context, index) {
      //       String chapter = '챕터${index + 1}';

      //       return FadeInLeft(
      //         delay: Duration(milliseconds: 200 * index),
      //         child:
      //             BookCard(level: chapter, onTap: () => goTo(index, chapter)),
      //       );
      //     },
      //   ),
      //   bottomNavigationBar: const GlobalBannerAdmob(),
      // );
    }
    return GridView.builder(
      itemCount: kangiController.headTitleCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (context, index) {
        String chapter = '챕터${index + 1}';
        return InkWell(
          onTap: () {
            goTo(index, chapter);
          },
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' ${(index + 1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (index == 0) Text('Progress..')
              ],
            ),
          )),
        );
      },
    );
    // return ListView.separated(
    //   itemCount: kangiController.headTitleCount,
    //   separatorBuilder: (context, index) {
    //     if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
    //       return NativeAdWidget();
    //     }
    //     return Container();
    //   },
    //   itemBuilder: (context, index) {
    //     String chapter = '챕터${index + 1}';

    //     return FadeInLeft(
    //       delay: Duration(milliseconds: 200 * index),
    //       child: BookCard(
    //         level: chapter,
    //         onTap: () => goTo(index, chapter),
    //       ),
    //     );
    //   },
    // );
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
