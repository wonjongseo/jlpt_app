import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/app_bar_progress_bar.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';

import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

final String JLPT_STUDY_PATH = '/jlpt_study';

// ignore: must_be_immutable
class JlptStudyScreen extends StatelessWidget {
  final JlptStudyController wordController = Get.put(JlptStudyController());

  SettingController settingController = Get.find<SettingController>();
  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();
  JlptStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptStudyController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          actions: const [
            HeartCount(),
          ],
          title: RichText(
            text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
                children: [
                  TextSpan(
                    text: '${controller.currentIndex + 1}',
                    style: TextStyle(
                      color: Colors.cyan.shade500,
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: ' / '),
                  TextSpan(text: '${controller.jlptStep.words.length}')
                ]),
          ),
          // title: Text(
          //     '${controller.currentIndex + 1} / ${controller.jlptStep.words.length}'),
        ),
        body: _body(context, controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  Widget _body(BuildContext context, JlptStudyController controller) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Expanded(
            //   flex: 1,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: GetBuilder<TtsController>(builder: (ttsController) {
            //       return Stack(
            //         children: [
            //           if (ttsController.isPlaying)
            //             const Align(
            //                 alignment: Alignment.bottomCenter,
            //                 child: SpinKitWave(
            //                   size: 30,
            //                   color: Colors.black,
            //                 )),
            //           // if (!settingController.isAutoSave &&
            //           //     !wordController.isWordSaved)
            //           Align(
            //             alignment: Alignment.bottomLeft,
            //             child: OutlinedButton(
            //               onPressed: () {
            //                 if (!wordController.isWordSaved) {
            //                   wordController.isWordSaved = true;
            //                   wordController.saveCurrentWord();
            //                 }

            //                 wordController.update();
            //               },
            //               child: const Text(
            //                 '저장',
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           if (wordController.words.length >= 4)
            //             Align(
            //               alignment: Alignment.bottomRight,
            //               child: OutlinedButton(
            //                 onPressed: () async {
            //                   bool result = await askToWatchMovieAndGetHeart(
            //                     title: const Text('점수를 기록하고 하트를 채워요!'),
            //                     content: const Text(
            //                       '테스트 페이지로 넘어가시겠습니까?',
            //                       style: TextStyle(
            //                           color: AppColors.scaffoldBackground),
            //                     ),
            //                   );

            //                   if (result) {
            //                     wordController.goToTest();
            //                   }
            //                 },
            //                 child: const Text(
            //                   '시험',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //         ],
            //       );
            //     }),
            //   ),
            // ),

            Expanded(
              flex: 7,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.words.length,
                itemBuilder: (context, index) {
                  return WordCard(
                      word: controller.words[index], controller: controller);
                },
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(onPressed: () {}, child: Text('학습')))
      ],
    );
  }

  AppBar _appBar2(Size size, double currentValue) {
    return AppBar(
      actions: const [
        HeartCount(),
      ],
      leading: IconButton(
        onPressed: () async {
          wordController.jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: AppBarProgressBar(size: size, currentValue: currentValue),
    );
  }

  AppBar _appBar(Size size, double currentValue) {
    return AppBar(
      actions: const [
        HeartCount(),
      ],
      leading: IconButton(
        onPressed: () async {
          wordController.jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: AppBarProgressBar(size: size, currentValue: currentValue),
    );
  }
}
