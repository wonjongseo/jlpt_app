import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/kangi/kangi_test/controller/kangi_test_controller.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/kangi/kangi_test/components/kangi_test_card.dart';
import 'package:japanese_voca/entity/jlpt_and_kangi/common/progress_bar.dart';

import '../../../../config/colors.dart';

const KANGI_TEST_PATH = '/kangi_test';
const KANGI_TEST = 'kangi';
const CONTINUTE_KANGI_TEST = 'continue_kangi_test';

class KangiTestScreen extends StatelessWidget {
  const KangiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    KangiTestController kangiQuestionController =
        Get.put(KangiTestController());

    // TODO FIX
    // BannerAdController bannerAdController = Get.find<BannerAdController>();

    // if (!bannerAdController.loadingScoreBanner) {
    //   bannerAdController.loadingScoreBanner = true;
    //   bannerAdController.createScoreBanner();
    // }

    // 모든 문제로 테스트 준비해기
    if (Get.arguments != null && Get.arguments[KANGI_TEST] != null) {
      kangiQuestionController.startKangiQuiz(Get.arguments[KANGI_TEST]);
    }
    // 과거에 틀린 문제로만 테스트 준비하기
    else {
      kangiQuestionController.startKangiQuizHistory(
        Get.arguments[CONTINUTE_KANGI_TEST],
      );
    }

    return Scaffold(
      appBar: _appBar(kangiQuestionController),
      body: _body(kangiQuestionController, context),
      // bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  SafeArea _body(
      KangiTestController kangiQuestionController, BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(
              (() => Text.rich(
                    TextSpan(
                      text:
                          "問題 ${kangiQuestionController.questionNumber.value}",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                              ),
                      children: [
                        TextSpan(
                          text: "/${kangiQuestionController.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: kangiQuestionController.pageController,
              onPageChanged: kangiQuestionController.updateTheQnNum,
              itemCount: kangiQuestionController.questions.length,
              itemBuilder: (context, index) {
                return KangiQuestionCard(
                  question: kangiQuestionController.questions[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(KangiTestController kangiQuestionController) {
    return AppBar(
      title: const ProgressBar(
        isKangi: true,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          getBacks(2);
        },
      ),
      iconTheme: const IconThemeData(color: AppColors.scaffoldBackground),
      actions: [
        GetBuilder<KangiTestController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: TextButton(
              onPressed: kangiQuestionController.skipQuestion,
              child: Text(
                controller.text,
                style: TextStyle(color: controller.color, fontSize: 20),
              ),
            ),
          );
        })
      ],
    );
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.scoreBanner);
      },
    );
  }
}
