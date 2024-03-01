import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';

import '../jlpt_study_controller.dart';

class JlptStudyButtonsTemp extends StatelessWidget {
  const JlptStudyButtonsTemp({
    Key? key,
    required this.wordController,
  }) : super(key: key);

  final JlptStudyControllerTemp wordController;
  @override
  Widget build(BuildContext context) {
    double buttonWidth = threeWordButtonWidth;
    double buttonHeight = 55;
    return GetBuilder<TtsController>(builder: (ttsController) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomOut(
                animate: wordController.isShownYomikata,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: ttsController.disalbe
                        ? null
                        : () {
                            if (!wordController.isShownYomikata) {
                              wordController.showYomikata();
                            }
                          },
                    child: Text(
                      '읽는 법',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimentions.width15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () async {
                    await wordController.nextWord(false);
                  },
                  child: Text(
                    '몰라요',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width15,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimentions.width10),
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () async {
                    if (wordController.isShownYomikata) {
                      await wordController.speakYomikata();
                    }
                    await Future.delayed(const Duration(microseconds: 100));
                    if (wordController.isShownMean) {
                      await wordController.speakMean();
                    }
                  },
                  child: Text(
                    '듣기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width15,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimentions.width10),
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () async {
                    await wordController.nextWord(true);
                  },
                  child: Text(
                    '알아요',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomOut(
                animate: wordController.isShownMean,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!wordController.isShownMean) {
                        wordController.showMean();
                      }
                    },
                    child: Text(
                      '의미',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimentions.width15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
