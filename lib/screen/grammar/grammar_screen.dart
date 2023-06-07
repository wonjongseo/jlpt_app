import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/screen/grammar/controller/grammar_controller.dart';
import 'package:japanese_voca/screen/grammar/quiz/grammar_quiz_screen.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';

import '../../common/common.dart';
import '../../config/colors.dart';

const String GRAMMER_PATH = '/grammar';

class GrammerScreen extends StatefulWidget {
  const GrammerScreen({super.key});

  @override
  State<GrammerScreen> createState() => _GrammerScreenState();
}

class _GrammerScreenState extends State<GrammerScreen> {
  GrammarController grammarController = Get.find<GrammarController>();
  final BannerAdController bannerAadController = Get.find<BannerAdController>();
  late GrammarStep grammarStep;
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();

    initData();
  }

  void initData() async {
    grammarStep = grammarController.getGrammarStep();
  }

  @override
  Widget build(BuildContext context) {
    if (!bannerAadController.loadingStudyBanner) {
      bannerAadController.loadingStudyBanner = true;
      bannerAadController.createStudyBanner();
    }
    return Scaffold(
      body: _body(context),
      appBar: _appBar(),
      bottomNavigationBar: GetBuilder<BannerAdController>(
        builder: (controller) {
          return BannerContainer(bannerAd: bannerAadController.studyBanner);
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(),
      title: Text('N${grammarStep.level} 문법 - ${grammarStep.step + 1} '),
      actions: const [HeartCount()],
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                bool result = await askToWatchMovieAndGetHeart(
                  title: const Text('점수를 기록하고 하트를 채워요!'),
                  content: const Text(
                    '테스트 페이지로 넘어가시겠습니까?',
                    style: TextStyle(color: AppColors.scaffoldBackground),
                  ),
                );
                if (result) {
                  Get.toNamed(GRAMMAR_QUIZ_SCREEN, arguments: {
                    'grammar': grammarStep.grammars,
                  });
                  return;
                }
              },
              child: const Text(
                'TEST',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
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
        ),
      ],
    );
  }
}
