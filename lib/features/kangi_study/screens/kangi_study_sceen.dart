import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/common.dart';
import '../../../common/controller/tts_controller.dart';
import '../../setting/services/setting_controller.dart';

final String KANGI_STUDY_PATH = '/kangi_study';
final String IS_TEST_AGAIN = 'isTestAgain';

// ignore: must_be_immutable
class KangiStudySceen extends StatefulWidget {
  final int currentIndex;
  const KangiStudySceen({super.key, required this.currentIndex});

  @override
  State<KangiStudySceen> createState() => _KangiStudySceenState();
}

class _KangiStudySceenState extends State<KangiStudySceen> {
  SettingController settingController = Get.find<SettingController>();
  final KangiStepController kangiStepController =
      Get.find<KangiStepController>();

  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    kangiStepController.currentIndex = widget.currentIndex;
    currentIndex = widget.currentIndex;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KangiStepController>(builder: (controller) {
      return Scaffold(
        appBar: _appBar(controller),
        body: _body(controller),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }

  AppBar _appBar(KangiStepController controller) {
    return AppBar(
      actions: const [
        HeartCount(),
      ],
      title: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: Responsive.height10 * 2,
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
            TextSpan(text: '${controller.getKangiStep().kangis.length}')
          ],
        ),
      ),
    );
  }

  Widget _body(KangiStepController controller) {
    return Stack(
      children: [
        GetBuilder<TtsController>(builder: (ttsController) {
          return PageView.builder(
            controller: pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.getKangiStep().kangis.length,
            itemBuilder: (context, index) {
              return KangiCard(
                  controller: controller,
                  kangi: controller.getKangiStep().kangis[index]);
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
