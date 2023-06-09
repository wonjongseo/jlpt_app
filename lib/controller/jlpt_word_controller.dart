import 'package:get/get.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';

import '../model/Question.dart';
import 'user_controller.dart';

class JlptWordController extends GetxController {
  List<JlptStep> jlptSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;
  int countOfWrong = 0;

  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();
  UserController userController = Get.find<UserController>();
  JlptWordController({required this.level}) {
    headTitleCount = jlptStepRepositroy.getCountByJlptHeadTitle(level);
  }

  /**
   * 테스트로 만점이면 초기화.
   */
  void setStep(int step) {
    this.step = step;

    if (jlptSteps[step].scores == jlptSteps[step].words.length) {
      clearScore();
    }
  }

  void clearScore() {
    int score = jlptSteps[step].scores;
    jlptSteps[step].scores = 0;
    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
    userController.updateCurrentProgress(
        TotalProgressType.JLPT, int.parse(level) - 1, -score);
  }

  void updateScore(int score, List<Question> wrongQestion) {
    // 모든 점수에 해당 점수가 이미 기록 되어 있던가 ?
    int previousScore = jlptSteps[step].scores;

    if (previousScore != 0) {
      userController.updateCurrentProgress(
          TotalProgressType.JLPT, int.parse(level) - 1, -previousScore);
    }

    score = score + previousScore;

    // 다 맞췄으면
    if (score == jlptSteps[step].words.length) {
      jlptSteps[step].isFinished = true;
    }
    // 에러 발생.
    else if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
    }

    if (jlptSteps[step].wrongQestion != null) {
      for (int i = 0; i < jlptSteps[step].wrongQestion!.length; i++) {
        for (int j = 0; j < wrongQestion.length; j++) {
          if (jlptSteps[step].wrongQestion![i] == wrongQestion[j]) {}
        }
      }
    }

    jlptSteps[step].wrongQestion = wrongQestion;
    jlptSteps[step].scores = score;
    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
    userController.updateCurrentProgress(
        TotalProgressType.JLPT, int.parse(level) - 1, score);

    // 처음 보던가
  }

  JlptStep getJlptStep() {
    return jlptSteps[step];
  }

  void setJlptSteps(String headTitle) {
    this.headTitle = headTitle;
    jlptSteps =
        jlptStepRepositroy.getJlptStepByHeadTitle(level, this.headTitle);

    update();
  }
}
