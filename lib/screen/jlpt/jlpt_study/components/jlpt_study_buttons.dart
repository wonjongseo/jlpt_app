import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_controller.dart';

import '../../../../kangi_study_sceen.dart';

class JlptStudyButtons extends StatelessWidget {
  const JlptStudyButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JlptStudyController>(builder: (wordController) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomOut(
                animate: wordController.isShownMean,
                duration: const Duration(milliseconds: 300),
                child: KangiButton(
                  width: 100,
                  height: 45,
                  text: '의미',
                  onTap: () {
                    if (!wordController.isShownMean) {
                      wordController.showMean();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              ZoomOut(
                animate: wordController.isShownYomikata,
                duration: const Duration(milliseconds: 300),
                child: KangiButton(
                  width: 100,
                  height: 45,
                  text: '읽는 법',
                  onTap: () {
                    if (!wordController.isShownYomikata) {
                      wordController.showYomikata();
                    }
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KangiButton(
                width: 100,
                height: 45,
                text: '몰라요',
                onTap: () {
                  wordController.nextWord(false);
                },
              ),
              const SizedBox(width: 16),
              KangiButton(
                width: 100,
                height: 45,
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
