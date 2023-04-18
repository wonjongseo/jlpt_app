import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/word/word_study/components/word_study_buttons.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/word/word_study/components/word_study_card.dart';
import 'package:japanese_voca/screen/word/word_study/word_controller.dart';

final String WORD_STUDY_PATH = '/word_study';

// ignore: must_be_immutable
class WordStudyScreen extends StatelessWidget {
  late WordStudyController wordController;

  WordStudyScreen({super.key}) {
    if (Get.arguments != null && Get.arguments['againTest']) {
      wordController = Get.put(WordStudyController(isAgainTest: true));
    } else {
      wordController = Get.put(WordStudyController());
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _appBar(size),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BackgroundWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<WordStudyController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Word currentWord =
                        wordController.words[wordController.currentIndex];
                    MyWord.saveMyVoca(currentWord, isManualSave: true);
                  },
                  icon: SvgPicture.asset('assets/svg/save.svg'),
                ),
              ),
              const Spacer(flex: 1),
              WordStrudyCard(controller: controller),
              const SizedBox(height: 32),
              const WordStudyButtons(),
              const Spacer(flex: 1),
            ],
          );
        }),
      ),
    );
  }

  AppBar _appBar(Size size) {
    return AppBar(
      actions: [
        if (wordController.words.length >= 4)
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton(
              onPressed: wordController.goToTest,
              child: const Text('TEST'),
            ),
          ),
      ],
      leading: IconButton(
        onPressed: () async {
          wordController.jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: GetBuilder<WordStudyController>(builder: (controller) {
        double currentValue = ((controller.currentIndex).toDouble() /
                controller.words.length.toDouble()) *
            100;
        return FAProgressBar(
          currentValue: currentValue,
          maxValue: 100,
          displayText: '%',
          size: size.width > 500 ? 35 : 25,
          formatValueFixed: 0,
          backgroundColor: AppColors.darkGrey,
          progressColor: AppColors.lightGreen,
          borderRadius: size.width > 500
              ? BorderRadius.circular(30)
              : BorderRadius.circular(12),
          displayTextStyle: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: size.width > 500 ? 18 : 14),
        );
      }),
    );
  }
}
