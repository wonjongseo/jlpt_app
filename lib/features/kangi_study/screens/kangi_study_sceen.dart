import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/kangi_study/controller/kangi_study_controller.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';
import 'package:japanese_voca/model/kangi.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/common.dart';
import '../../../common/widget/app_bar_progress_bar.dart';
import '../../../config/theme.dart';
import '../../../common/controller/tts_controller.dart';
import '../../setting/services/setting_controller.dart';
import '../widgets/kangi_button.dart';

final String KANGI_STUDY_PATH = '/kangi_study';
final String IS_TEST_AGAIN = 'isTestAgain';

// ignore: must_be_immutable
class KangiStudySceen extends StatelessWidget {
  KangiStudySceen({super.key}) {
    if (Get.arguments != null && Get.arguments[IS_TEST_AGAIN] != null) {
      kangiStudyController = Get.put(KangiStudyController());
    } else {
      kangiStudyController = Get.put(KangiStudyController());
    }
  }
  // UserController userController = Get.find<UserController>();
  late KangiStudyController kangiStudyController;
  SettingController settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<KangiStudyController>(builder: (controller) {
      double currentValue = controller.getCurrentProgressValue();

      return Scaffold(
        appBar: _appBar(controller),
        body: _body(controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  AppBar _appBar(KangiStudyController controller) {
    return AppBar(
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
              ),
            ),
            const TextSpan(text: ' / '),
            TextSpan(text: '${controller.kangiStep.kangis.length}')
          ],
        ),
      ),
    );
  }

  Widget _body(KangiStudyController controller) {
    return Stack(
      children: [
        GetBuilder<TtsController>(builder: (ttsController) {
          return PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.kangis.length,
            itemBuilder: (context, index) {
              return KangiCard(
                  controller: controller, kangi: controller.kangis[index]);
            },
          );
        }),
        Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('점수를 기록하고 하트를 채워요!'),
                    content: const Text(
                      '테스트 페이지로 넘어가시겠습니까?',
                      style: TextStyle(color: AppColors.scaffoldBackground),
                    ),
                  );

                  if (result) {
                    controller.goToTest();
                  }
                },
                child: Text('학습')))
      ],
    );
  }
}

// class KangiStudyButtons extends StatelessWidget {
//   const KangiStudyButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double buttonWidth = size.width * 0.29;
//     double buttonHeight = 50;

//     return GetBuilder<KangiStudyController>(builder: (controller) {
//       return GetBuilder<TtsController>(builder: (tController) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ZoomOut(
//                   animate: controller.isShownUndoc,
//                   duration: const Duration(milliseconds: 300),
//                   child: KangiButton(
//                     text: '음독',
//                     width: buttonWidth,
//                     height: buttonHeight,
//                     onTap: tController.disalbe ? null : controller.showUndoc,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 KangiButton(
//                   text: '몰라요',
//                   width: buttonWidth,
//                   height: buttonHeight,
//                   onTap: tController.disalbe
//                       ? null
//                       : () => controller.nextWord(false),
//                 ),
//                 SizedBox(width: Dimentions.width10),
//                 ZoomOut(
//                   animate: controller.isShownKorea,
//                   duration: const Duration(milliseconds: 300),
//                   child: KangiButton(
//                     text: '한자',
//                     width: buttonWidth,
//                     height: buttonHeight,
//                     onTap: tController.disalbe ? null : controller.showYomikata,
//                   ),
//                 ),
//                 SizedBox(width: Dimentions.width10),
//                 KangiButton(
//                   width: buttonWidth,
//                   height: buttonHeight,
//                   text: '알아요',
//                   onTap: tController.disalbe
//                       ? null
//                       : () => controller.nextWord(true),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ZoomOut(
//                   animate: controller.isShownHundoc,
//                   child: KangiButton(
//                     text: '훈독',
//                     width: buttonWidth,
//                     height: buttonHeight,
//                     onTap: tController.disalbe ? null : controller.showHundoc,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
//       });
//     });
//   }
// }
