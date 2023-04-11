import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/jlpt_word_n1_data.dart';
import 'package:japanese_voca/screen/word/word_step/word_step_sceen.dart';

final String WORD_HIRAGANA_STEP_PATH = '/word-hiragana-step';

class WordHiraganaStepScreen extends StatelessWidget {
  const WordHiraganaStepScreen({super.key});

  void goTo(int index, String firstHiragana) {
    Get.toNamed(WORD_STEP_PATH, arguments: {'firstHiragana': firstHiragana});
  }

  @override
  Widget build(BuildContext context) {
    print('asdsasad');

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
                String firstHiragana = '';
                if (index == 9) {
                  firstHiragana = hiragas[10];
                } else if (index == 10) {
                  firstHiragana = hiragas[9];
                } else {
                  firstHiragana = hiragas[index];
                }

                return BookCard(
                    level: firstHiragana,
                    onTap: () => goTo(index, firstHiragana));
              },
            ),
          ),
        ),
      ),
    );
  }
}
