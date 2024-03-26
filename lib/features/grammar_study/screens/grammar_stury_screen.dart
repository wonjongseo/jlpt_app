import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/features/grammar_test/grammar_test_screen.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/features/grammar_step/widgets/grammar_card.dart';

const String GRAMMER_STUDY_PATH = '/grammar';

class GrammerStudyScreen extends StatefulWidget {
  const GrammerStudyScreen({super.key});

  @override
  State<GrammerStudyScreen> createState() => _GrammerStudyScreenState();
}

class _GrammerStudyScreenState extends State<GrammerStudyScreen> {
  GrammarController grammarController = Get.find<GrammarController>();
  UserController userController = Get.find<UserController>();

  late GrammarStep grammarStep;
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();
    grammarStep = grammarController.getGrammarStep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      appBar: _appBar(),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'N${grammarStep.level}문법 - 챕터${grammarStep.step + 1}',
        style: TextStyle(fontSize: Responsive.height10 * 2),
      ),
      actions: [
        const HeartCount(),
        if (grammarController.grammers.length >= 4)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('점수를 기록하고 하트를 채워요!'),
                    content: const Text(
                      '테스트 페이지로 넘어가시겠습니까?',
                      style: TextStyle(color: AppColors.scaffoldBackground),
                    ),
                  );
                  if (result) {
                    Get.toNamed(
                      GRAMMAR_TEST_SCREEN,
                      arguments: {
                        'grammar': grammarStep.grammars,
                      },
                    );
                  }
                },
                child: const Text(
                  '시험',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteGrey,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          grammarStep.grammars.length,
          (index) {
            grammarController.clickedIndex = index;
            grammarController.pageController =
                PageController(initialPage: index);
            return GrammarCard(
              index: index,
              grammars: grammarStep.grammars,
            );
          },
        ),
      ),
    );
  }
}
