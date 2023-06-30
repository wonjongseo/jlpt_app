import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/tts_controller.dart';

import '../../../../common/widget/dimentions.dart';
import 'controller/kangi_study_controller.dart';
import 'kangi_button.dart';

class KangiStudyButtonsTemp extends StatelessWidget {
  const KangiStudyButtonsTemp({super.key});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = threeWordButtonWidth;
    double buttonHeight = 55;

    return GetBuilder<KangiStudyController>(builder: (controller) {
      return GetBuilder<TtsController>(builder: (tController) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZoomOut(
                  animate: controller.isShownUndoc,
                  duration: const Duration(milliseconds: 300),
                  child: KangiButton(
                    text: '음독',
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: tController.disalbe ? null : controller.showUndoc,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KangiButton(
                  text: '몰라요',
                  width: buttonWidth,
                  height: buttonHeight,
                  onTap: tController.disalbe
                      ? null
                      : () => controller.nextWord(false),
                ),
                SizedBox(width: Dimentions.width10),
                ZoomOut(
                  animate: controller.isShownKorea,
                  duration: const Duration(milliseconds: 300),
                  child: KangiButton(
                    text: '한자',
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: tController.disalbe ? null : controller.showYomikata,
                  ),
                ),
                SizedBox(width: Dimentions.width10),
                KangiButton(
                  width: buttonWidth,
                  height: buttonHeight,
                  text: '알아요',
                  onTap: tController.disalbe
                      ? null
                      : () => controller.nextWord(true),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ZoomOut(
                  animate: controller.isShownHundoc,
                  child: KangiButton(
                    text: '훈독',
                    width: buttonWidth,
                    height: buttonHeight,
                    onTap: tController.disalbe ? null : controller.showHundoc,
                  ),
                ),
              ],
            ),
          ],
        );
      });
    });
  }
}
