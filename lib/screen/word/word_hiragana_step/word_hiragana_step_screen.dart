import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/jlpt_word_n1_data.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_step/word_step_sceen.dart';

final String WORD_HIRAGANA_STEP_PATH = '/word-hiragana-step';

class WordHiraganaStepScreen extends StatelessWidget {
  const WordHiraganaStepScreen({super.key});

  void goTo(int index, String firstHiragana) {
    Get.toNamed(WORD_STEP_PATH, arguments: {'firstHiragana': firstHiragana});
  }

  @override
  Widget build(BuildContext context) {
    JlptWordController jlptWordController = Get.find<JlptWordController>();

    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                jlptWordController.headTitleCount,
                (index) {
                  String firstHiragana = '챕터${index + 1}';
                  return BookCard(
                      level: firstHiragana,
                      onTap: () => goTo(index, firstHiragana));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
