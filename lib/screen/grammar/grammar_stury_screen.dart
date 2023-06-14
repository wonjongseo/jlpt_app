import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/screen/grammar/controller/grammar_controller.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';
import 'package:japanese_voca/screen/grammar/grammar_test/grammar_test_screen.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';

import '../../common/common.dart';
import '../../config/colors.dart';

const String GRAMMER_STUDY_PATH = '/grammar';

class GrammerStudyScreen extends StatefulWidget {
  const GrammerStudyScreen({super.key});

  @override
  State<GrammerStudyScreen> createState() => _GrammerStudyScreenState();
}

class _GrammerStudyScreenState extends State<GrammerStudyScreen> {
  GrammarController grammarController = Get.find<GrammarController>();
  UserController userController = Get.find<UserController>();
  late BannerAdController? bannerAadController;

  late GrammarStep grammarStep;
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();
    grammarStep = grammarController.getGrammarStep();
    grammarController.initAdFunction();
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(builder: (controller) {
      return BannerContainer(bannerAd: controller.testBanner);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      body: _body(context),
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  FloatingActionButton? _floatingActionButton() {
    if (grammarController.grammers.length >= 4) {
      return FloatingActionButton.extended(
          onPressed: () async {
            bool result = await askToWatchMovieAndGetHeart(
              title: const Text('점수를 기록하고 하트를 채워요!'),
              content: const Text(
                '테스트 페이지로 넘어가시겠습니까?',
                style: TextStyle(color: AppColors.scaffoldBackground),
              ),
            );
            if (result) {
              Get.toNamed(GRAMMAR_TEST_SCREEN, arguments: {
                'grammar': grammarStep.grammars,
              });
            }
          },
          label: const Text(
            '시험 보기',
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
    }
    return null;
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('N${grammarStep.level} 문법 - ${grammarStep.step + 1} '),
      actions: const [HeartCount()],
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            grammarStep.grammars.length,
            (index) {
              return GrammarCard(
                grammar: grammarStep.grammars[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
