import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/word/word_study/word_controller.dart';

import '../../../../common/widget/cusomt_button.dart';

class WordStudyButtons extends StatelessWidget {
  const WordStudyButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordStudyController>(builder: (wordController) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              wordController.isShownMean
                  ? ZoomOut(
                      animate: wordController.isShownMean,
                      duration: const Duration(milliseconds: 300),
                      child: CustomButton(
                        text: '의미',
                        onTap: () {
                          if (!wordController.isShownMean) {
                            wordController.showMean();
                          }
                        },
                      ),
                    )
                  : CustomButton(
                      text: '의미',
                      onTap: () {
                        if (!wordController.isShownMean) {
                          wordController.showMean();
                        }
                      },
                    ),
              const SizedBox(width: 16),
              wordController.isShownYomikata
                  ? ZoomOut(
                      animate: wordController.isShownYomikata,
                      duration: const Duration(milliseconds: 300),
                      child: CustomButton(
                        text: '읽는 법',
                        onTap: () {
                          if (!wordController.isShownYomikata) {
                            wordController.showYomikata();
                          }
                        },
                      ),
                    )
                  : CustomButton(
                      text: '읽는 법',
                      onTap: () {
                        if (!wordController.isShownYomikata) {
                          wordController.showYomikata();
                        }
                      },
                    ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: '몰라요',
                onTap: () {
                  wordController.nextWord(false);
                },
              ),
              const SizedBox(width: 16),
              CustomButton(
                text: '알아요',
                onTap: () {
                  wordController.nextWord(true);
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
