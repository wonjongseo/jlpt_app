import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/user_repository2.dart';

import '../model/Question.dart';
import '../user_controller2.dart';

class JlptWordController extends GetxController {
  List<JlptStep> jlptSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;
  int countOfWrong = 0;

  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();
  UserController2 userController2 = Get.find<UserController2>();
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
    userController2.updateCurrentProgress(
        TotalProgressType.JLPT, int.parse(level) - 1, -score);
  }

  void updateScore(int score, List<Question> wrongQestion,
      {bool isRetry = false}) {
    int previousScore = jlptSteps[step].scores;

    score = score + previousScore;

    if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
    }

    jlptSteps[step].scores = score;

    if (score == jlptSteps[step].words.length) {
      jlptSteps[step].isFinished = true;
    }

    jlptSteps[step].wrongQestion = wrongQestion;

    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
    userController2.updateCurrentProgress(
        TotalProgressType.JLPT, int.parse(level) - 1, score);
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
