import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/screen/word/word_step/word_step_sceen.dart';

final String WORD_HIRAGANA_STEP_PATH = '/word-hiragana-step';

class WordHiraganaStepScreen extends StatelessWidget {
  const WordHiraganaStepScreen({super.key});

  void goTo(int index, String level) {
    Get.toNamed(WORD_STEP_PATH, arguments: {'firstHiragana': level});
  }

  @override
  Widget build(BuildContext context) {
    KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              hiragas.length,
              (index) {
                // 부사와 형용사의 정렬이 반되로 되어있기 때문의 조건문
                String level = '';
                if (index == 9) {
                  level = hiragas[10];
                } else if (index == 10) {
                  level = hiragas[9];
                } else {
                  level = hiragas[index];
                }

                return BookCard(level: level, onTap: () => goTo(index, level));
              },
            ),
          ),
        ),
      ),
    );
  }
}
