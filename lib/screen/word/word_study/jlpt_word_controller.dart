import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';

class JlptWordController extends GetxController {
  List<JlptStep> jlptSteps = [];
  late String headTitle;
  late int step;
  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();

  void setStep(int step) {
    this.step = step;

    if (jlptSteps[step].scores == jlptSteps[step].words.length) {
      clearScore();
    }
  }

  void clearScore() {
    jlptSteps[step].scores = 0;
    update();
    jlptStepRepositroy.updateJlptStep(jlptSteps[step]);
  }

  void updateScore(int score, {bool isAgain = false}) {
    if (isAgain) {
      score = jlptSteps[step].scores + score;
    }
    if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
    }

    jlptSteps[step].scores = score;
    update();
    jlptStepRepositroy.updateJlptStep(jlptSteps[step]);
  }

  JlptStep getJlptStep() {
    return jlptSteps[step];
  }

  void setJlptSteps(String headTitle) {
    this.headTitle = headTitle;
    jlptSteps = jlptStepRepositroy.getJlptStepByHeadTitle(this.headTitle);

    update();
  }
}
