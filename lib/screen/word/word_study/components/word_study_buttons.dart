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
    WordController wordController = Get.find<WordController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: '의미',
              onTap: () => wordController.showMean(),
            ),
            const SizedBox(width: 16),
            CustomButton(
              text: '읽는 법',
              onTap: () => wordController.showYomikata(),
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
  }
}
