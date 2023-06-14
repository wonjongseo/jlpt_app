import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/kangi_test/controller/kangi_test_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/screen/score/components/wrong_word_card.dart';

const KANGI_SCORE_PATH = '/kangi_score';

class KangiScoreScreen extends StatelessWidget {
  const KangiScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO FIX
    // BannerAdController bannerAdController = Get.find<BannerAdController>();
    KangiTestController kangiQuestionController =
        Get.find<KangiTestController>();

    // TODO FIX
    // if (!bannerAdController.loadingScoreBanner) {
    //   bannerAdController.loadingScoreBanner = true;
    //   bannerAdController.createScoreBanner();
    // }
    return Scaffold(
      appBar: _appBar(kangiQuestionController),
      body: _body(kangiQuestionController, size),
      // TODO FIX
      // bottomNavigationBar: GetBuilder<BannerAdController>(
      //   builder: (controller) {
      //     return BannerContainer(bannerAd: controller.scoreBanner);
      //   },
      // ),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('나가기'),
                      onPressed: () => getBacks(3),
                    ),
                    const SizedBox(height: 20),
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
