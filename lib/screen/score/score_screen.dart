import 'package:flutter/material.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/screen/score/components/wrong_word_card.dart';

const SCORE_PATH = '/score';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO VAR
    // BannerAdController bannerAdController = Get.find<BannerAdController>();
    QuestionController qnController = Get.find<QuestionController>();

    // if (!bannerAdController.loadingScoreBanner) {
    //   bannerAdController.loadingScoreBanner = true;
    //   bannerAdController.createScoreBanner();
    // }
    return Scaffold(
      appBar: _appBar(qnController),
      body: _body(qnController, size),
      // bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.scoreBanner);
      },
    );
  }

  Stack _body(QuestionController qnController, Size size) {
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
                    if (qnController.wrongQuestions.isEmpty)
                      const SizedBox(width: double.infinity)
                    else
                      ...List.generate(qnController.wrongQuestions.length,
                          (index) {
                        String word = qnController.wrongWord(index);
                        String mean = qnController.wrongMean(index);
                        return WrongWordCard(
                          onTap: () => MyWord.saveToMyVoca(
                            qnController.wrongQuestions[index].question,
                            isManualSave: true,
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

  AppBar _appBar(QuestionController qnController) {
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
