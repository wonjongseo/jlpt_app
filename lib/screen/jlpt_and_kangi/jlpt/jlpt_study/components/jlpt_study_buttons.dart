import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/jlpt/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/kangi/kangi_study/kangi_button.dart';

class JlptStudyButtons extends StatelessWidget {
  const JlptStudyButtons({
    Key? key,
    required this.wordController,
  }) : super(key: key);

  final JlptStudyController wordController;
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 130;
    double buttonHeight = 50;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZoomOut(
              animate: wordController.isShownMean,
              duration: const Duration(milliseconds: 300),
              child: KangiButton(
                width: buttonWidth,
                height: buttonHeight,
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
                width: buttonWidth,
                height: buttonHeight,
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
              width: buttonWidth,
              height: buttonHeight,
              text: '몰라요',
              onTap: () async {
                await wordController.nextWord(false);
              },
            ),
            const SizedBox(width: 16),
            KangiButton(
              width: buttonWidth,
              height: buttonHeight,
              text: '알아요',
              onTap: () async {
                await wordController.nextWord(true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
