import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/test_banner_ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/features/kangi_test/controller/kangi_test_controller.dart';
import 'package:japanese_voca/features/kangi_test/components/kangi_test_card.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/widgets/progress_bar.dart';

import '../../config/colors.dart';

const KANGI_TEST_PATH = '/kangi_test';
const KANGI_TEST = 'kangi';
const CONTINUTE_KANGI_TEST = 'continue_kangi_test';

class KangiTestScreen extends StatelessWidget {
  const KangiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    KangiTestController kangiTestController = Get.put(KangiTestController());

    kangiTestController.init(Get.arguments);

    return Scaffold(
      appBar: _appBar(kangiTestController),
      body: _body(context),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _body(BuildContext context) {
    return GetBuilder<KangiTestController>(builder: (kangiQuestionController) {
      return IgnorePointer(
        ignoring: kangiQuestionController.isDisTouchable,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text.rich(
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
        ),
      );
    });
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
        onPressed: () async {
          bool result = await reallyQuitText();
          if (result) {
            getBacks(2);
            return;
          }
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

  GetBuilder<TestBannerAdController> _bottomNavigationBar() {
    return GetBuilder<TestBannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.testBanner);
      },
    );
  }
}
