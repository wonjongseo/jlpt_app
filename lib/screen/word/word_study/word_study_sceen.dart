import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/word/word_study/components/word_study_buttons.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/word/word_study/components/word_study_card.dart';
import 'package:japanese_voca/screen/word/word_study/word_controller.dart';

final String WORD_STUDY_PATH = '/word_study';

// ignore: must_be_immutable
class WordStudyScreen extends StatelessWidget {
  late WordController wordController;

  WordStudyScreen() {
    if (Get.arguments != null && Get.arguments['againTest']) {
      print('Get.arguments["againTest"]: ${Get.arguments['againTest']}');

      wordController = Get.put(WordController(isAgainTest: true));
    } else {
      print('aaaa');
      wordController = Get.put(WordController());
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<WordController>(builder: (controller) {
          return WordStrudyCard(controller: controller);
        }),
        const SizedBox(height: 32),
        const WordStudyButtons(),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      actions: [
        if (wordController.words.length >= 4)
          TextButton(
            onPressed: wordController.goToTest,
            child: const Text('TEST'),
          ),
        const SizedBox(width: 15),
        IconButton(
            onPressed: () {
              Word currentWord =
                  wordController.words[wordController.currentIndex];
              MyWord.saveMyVoca(currentWord, isManualSave: true);
            },
            icon: SvgPicture.asset('assets/svg/save.svg')),
        const SizedBox(width: 15),
      ],
      leading: IconButton(
        onPressed: () async {
          wordController.jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: GetBuilder<WordController>(builder: (controller) {
        return Text(
            '${controller.currentIndex + 1} / ${controller.words.length}');
      }),
    );
  }
}
