import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/kangi/kangi_study/kangi_study_controller.dart';
import 'package:japanese_voca/screen/word/word_study/word_controller.dart';

import '../../../../common/widget/cusomt_button.dart';

class KangiStudyButtons extends StatelessWidget {
  const KangiStudyButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    KangiController wordController = Get.find<KangiController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: '운독',
              onTap: () => wordController.showUndoc(),
            ),
            const SizedBox(width: 16),
            CustomButton(
              text: '한글',
              onTap: () => wordController.showKorean(),
            ),
            const SizedBox(width: 16),
            CustomButton(
              text: '훈독',
              onTap: () => wordController.showHundoc(),
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
