import 'dart:math';

import 'package:flutter/material.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/features/score/components/wrong_word_card.dart';

const SCORE_PATH = '/score';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  JlptTestController qnController = Get.find<JlptTestController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Random randDom = Random();

      int randomNumber = randDom.nextInt(20) + 20; // is >=20 and40

      if (qnController.userController.clickUnKnownButtonCount > randomNumber) {
        bool result = await askToWatchMovieAndGetHeart(
          title: const Text('저장한 단어를 복습하러 가요!'),
          content: const Text(
            '자주 틀리는 단어장에 가서 단어들을 복습 하시겠습니까?',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );
        if (result) {
          qnController.userController.clickUnKnownButtonCount = 0;
          qnController.isMyWordTest ? getBacks(2) : getBacks(3);
          Get.toNamed(
            MY_VOCA_PATH,
            arguments: {
              MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
            },
          );
        } else {
          randomNumber = randDom.nextInt(2) + 2;
          qnController.userController.clickUnKnownButtonCount =
              (qnController.userController.clickUnKnownButtonCount /
                      randomNumber)
                  .floor();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(
          title: Text(
            "점수 ${qnController.scoreResult}",
            style: TextStyle(fontSize: appBarTextSize),
          ),
        ),
      ),
      body: _body(qnController, size),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  Widget _body(JlptTestController qnController, Size size) {
    return Padding(
      padding: EdgeInsets.all(Responsive.height16 / 2),
      child: Padding(
        padding: EdgeInsets.all(Responsive.height16 / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '오답',
              style: TextStyle(
                  color: Colors.cyan.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.height10 * 2),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(qnController.wrongQuestions.length,
                      (index) {
                    String word = qnController.wrongWord(index);
                    String mean = qnController.wrongMean(index);

                    return InkWell(
                      onTap: () => qnController.manualSaveToMyVoca(index),
                      child: Container(
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.3)),
                        child: ListTile(
                          leading: Text(
                            word,
                            style: TextStyle(
                                fontSize: Responsive.height10 * 1.8,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(mean),
                        ),
                      ),
                    ); // return WrongWordCard(
                    //   onTap: () => qnController.manualSaveToMyVoca(index),
                    //   textWidth: size.width / 2 - 20,
                    //   word: word,
                    //   mean: mean,
                    // );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
