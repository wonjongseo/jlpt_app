import 'dart:math';

import 'package:flutter/material.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/kangi_test/controller/kangi_test_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/features/score/components/wrong_word_card.dart';

const KANGI_SCORE_PATH = '/kangi_score';

class KangiScoreScreen extends StatelessWidget {
  const KangiScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    KangiTestController kangiQuestionController =
        Get.find<KangiTestController>();

    Future.delayed(const Duration(milliseconds: 1000), () async {
      Random randDom = Random();

      int randomNumber = randDom
              .nextInt(AppConstant.INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MIN) +
          AppConstant.INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MAX;

      if (kangiQuestionController.userController.clickUnKnownButtonCount >
          randomNumber) {
        bool result = await askToWatchMovieAndGetHeart(
          title: const Text('저장한 단어를 복습하러 가요!'),
          content: const Text(
            '자주 틀리는 단어장에 가서 단어들을 복습 하시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );
        if (result) {
          kangiQuestionController.userController.clickUnKnownButtonCount = 0;
          getBacks(3);
          Get.toNamed(
            MY_VOCA_PATH,
            arguments: {
              MY_VOCA_TYPE: MyVocaEnum.YOKUMATIGAERU_WORD,
            },
          );
        } else {
          randomNumber = randDom.nextInt(2) + 1;
          kangiQuestionController.userController.clickUnKnownButtonCount =
              (kangiQuestionController.userController.clickUnKnownButtonCount /
                      randomNumber)
                  .floor();
        }
      }
    });

    return Scaffold(
      // appBar: _appBar(kangiQuestionController),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(
          title: Text(
            "점수 ${kangiQuestionController.scoreResult}",
            style: TextStyle(fontSize: appBarTextSize),
          ),
        ),
      ),
      body: _body(kangiQuestionController, size),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  Stack _body(KangiTestController kangiQuestionController, Size size) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (kangiQuestionController.wrongQuestions.isEmpty)
                      const SizedBox(width: double.infinity)
                    else
                      ...List.generate(
                          kangiQuestionController.wrongQuestions.length,
                          (index) {
                        String word = kangiQuestionController.wrongWord(index);
                        String mean = kangiQuestionController.wrongMean(index);
                        return WrongWordCard(
                          // 수동
                          onTap: () => MyWord.saveToMyVoca(
                            kangiQuestionController
                                .wrongQuestions[index].question,
                          ),
                          textWidth: size.width / 2 - 20,
                          word: word,
                          mean: mean,
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  AppBar _appBar(KangiTestController qnController) {
    return AppBar(
      title: Text(
        "점수 ${qnController.scoreResult}",
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B94BC)),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => getBacks(3),
      ),
    );
  }
}
