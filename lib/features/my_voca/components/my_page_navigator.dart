import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/common/widget/custom_snack_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/features/my_voca/components/select_my_quiz_dialog.dart';
import 'package:japanese_voca/features/my_voca/screens/save_voca_screen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/my_voca/widgets/my_word_input_field.dart';
import 'package:japanese_voca/model/my_word.dart';

class MyPageNavigator extends StatelessWidget {
  MyPageNavigator({
    super.key,
    required this.knownWordCount,
    required this.unKnownWordCount,
    required this.value,
  });

  final int knownWordCount;
  final int unKnownWordCount;
  final List<MyWord> value;
  MyVocaController myVocaController = Get.find<MyVocaController>();

  void deleteAllData() async {
    bool result = await CommonDialog.askToDeleteAllMyWord(value.length);

    if (!result) return;

    int deletedWordCount = myVocaController.deleteArrayWords(
      value,
      isYokumatiageruWord: !myVocaController.isManualSavedWordPage,
    );
    showSnackBar(
      '$deletedWordCount개의 단어가 삭제 되었습니다.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width10 * 0.8),
      child: Stack(
        children: [
          if (value.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
                ),
                onPressed: deleteAllData,
                child: Text(
                  AppString.deleteAllBtn.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Responsive.height14,
                  ),
                ),
              ),
            ),
          if (myVocaController.isManualSavedWordPage)
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
                ),
                child: Text(
                  AppString.addBtn.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Responsive.height14,
                  ),
                ),
                onPressed: () {
                  Get.to(() => const SaveWordScreen());
                },
              ),
            ),
          if (value.length >= 4)
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.width20),
                ),
                child: Text(
                  AppString.doQuizBtn.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: Responsive.height14,
                  ),
                ),
                onPressed: () {
                  Get.dialog(
                    SelectMyQuizDialog(
                      myWords: value,
                      knownWordCount: knownWordCount,
                      unKnownWordCount: unKnownWordCount,
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
