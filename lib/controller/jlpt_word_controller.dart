import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';

class JlptWordController extends GetxController {
//  List<List<JlptStep>> jlptSteps = [];
  List<JlptStep> jlptSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int currentHeadTitleStep;
  late int step;
  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();

  JlptWordController({required this.level}) {
    headTitleCount = jlptStepRepositroy.getCountByJlptHeadTitle(level);
  }

  void setStep(int step) {
    this.step = step;

    if (jlptSteps[step].scores == jlptSteps[step].words.length) {
      clearScore();
    }
  }

  void clearScore() {
    jlptSteps[step].scores = 0;
    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
  }

  void updateScore(int score) {
    if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
    }

    if (score == jlptSteps[step].words.length) {
      jlptSteps[step].isFinished = true;
    }

    jlptSteps[step].scores = score;
    update();
    jlptStepRepositroy.updateJlptStep(level, jlptSteps[step]);
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
