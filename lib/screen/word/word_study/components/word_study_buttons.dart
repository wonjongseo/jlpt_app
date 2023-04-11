import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
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
              ZoomOut(
                animate: wordController.isShownMean,
                duration: const Duration(milliseconds: 300),
                child: CustomButton(
                  text: '의미',
                  onTap: () => wordController.showMean(),
                ),
              ),
              const SizedBox(width: 16),
              ZoomOut(
                animate: wordController.isShownYomikata,
                duration: const Duration(milliseconds: 300),
                child: CustomButton(
                  text: '읽는 법',
                  onTap: () => wordController.showYomikata(),
                ),
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
