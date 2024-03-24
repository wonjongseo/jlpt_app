import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/calendar_step_sceen.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/admob/native_ad/native_ad_widget.dart';
import '../../../common/app_constant.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatefulWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;

  final String level;
  final CategoryEnum categoryEnum;

  BookStepScreen({super.key, required this.level, required this.categoryEnum}) {
    if (categoryEnum == CategoryEnum.Japaneses) {
      jlptWordController = Get.put(JlptStepController(level: level));
    } else {
      kangiController = Get.put(KangiStepController(level: level));
    }
  }

  @override
  State<BookStepScreen> createState() => _BookStepScreenState();
}

class _BookStepScreenState extends State<BookStepScreen> {
  int isProgrssing = 0;
  UserController userController = Get.find<UserController>();

  void goTo(int index, String chapter) {
    if (widget.categoryEnum == CategoryEnum.Japaneses) {
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'categoryEnum': widget.categoryEnum});
    } else {
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'categoryEnum': widget.categoryEnum});
    }
  }

  @override
  void initState() {
    super.initState();
    isProgrssing = LocalReposotiry.getCurrentProgressing(
        '${widget.categoryEnum.name}-${widget.level}');
  }

  @override
  Widget build(BuildContext context) {
    bool isJapanese = widget.categoryEnum == CategoryEnum.Japaneses;
    Get.put(TtsController());
    // if (widget.categoryEnum == CategoryEnum.Japaneses) {

    return GridView.builder(
      itemCount: isJapanese
          ? widget.jlptWordController.headTitleCount
          : widget.kangiController.headTitleCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            isProgrssing = LocalReposotiry.putCurrentProgressing(
                '${widget.categoryEnum.name}-${widget.level}', index);

            goTo(index, '챕터${index + 1}');
            setState(() {});
          },
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Text(
                  ' ${(index + 1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (isProgrssing == index)
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

    if (true) {
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
      itemCount: widget.kangiController.headTitleCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (context, index) {
        String chapter = '챕터${index + 1}';
        return InkWell(
          onTap: () {
            isProgrssing = LocalReposotiry.putCurrentProgressing(
                '${widget.categoryEnum.name}-${widget.level}', index);
            goTo(index, chapter);
            setState(() {});
          },
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Text(
                  ' ${(index + 1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (isProgrssing == index)
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
        title: Text('N${widget.level}급 한자'),
        actions: const [HeartCount()],
      ),
      body: ListView.separated(
        itemCount: widget.kangiController.headTitleCount,
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
