import 'dart:math';

import 'package:flutter/material.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/kangi_test/controller/kangi_test_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';

const KANGI_SCORE_PATH = '/kangi_score';

class KangiScoreScreen extends StatelessWidget {
  const KangiScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    KangiTestController kangiQuestionController =
        Get.find<KangiTestController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Random randDom = Random();

      int randomNumber = randDom
              .nextInt(AppConstant.INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MIN) +
          AppConstant.INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MAX;

      if (kangiQuestionController.userController.clickUnKnownButtonCount >
          randomNumber) {
        int savedDataCount =
            kangiQuestionController.userController.user.yokumatigaeruMyWords;

        bool result =
            await CommonDialog.askGoToMyVocaPageDialog(savedDataCount);

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
          scrolledUnderElevation: 0.0,
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

  Widget _body(KangiTestController qnController, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.width16,
            vertical: Responsive.height8,
          ),
          child: Text(
            '오답',
            style: TextStyle(
                color: AppColors.mainBordColor,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.height10 * 2),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: List.generate(
                  qnController.wrongQuestions.length,
                  (index) {
                    String word = qnController.wrongWord(index); //  한자
                    String meanAndYomikata = qnController.wrongMean(index);

                    String hundocAndUndoc = meanAndYomikata.split('\n')[1]; //
                    String undoc = hundocAndUndoc.split('@')[0];
                    String hundoc = hundocAndUndoc.split('@')[1];
                    String yomikata = '음독: $undoc\n훈독: $hundoc';
                    // yomikata = yomikata.replaceAll('@', ' / ');
                    String mean = meanAndYomikata.split('\n')[0]; //한자 읽는 법

                    return InkWell(
                      onTap: () => qnController.manualSaveToMyVoca(index),
                      child: Container(
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.3)),
                        child: ListTile(
                          minLeadingWidth: 80,
                          isThreeLine: true,
                          leading: Text(
                            word,
                            style: TextStyle(
                              fontSize: Responsive.height10 * 2,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.japaneseFont,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          title: Text(mean),
                          subtitle: Text(yomikata),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
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
