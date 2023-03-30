import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

class KangiStepController extends GetxController {
  List<KangiStep> kangiSteps = [];
  late String headTitle;
  late int step;
  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

  void setStep(int step) {
    this.step = step;

    if (kangiSteps[step].scores == kangiSteps[step].kangis.length) {
      clearScore();
    }
  }

  void clearScore() {
    kangiSteps[step].scores = 0;
    update();
    kangiStepRepositroy.updateKangiStep(kangiSteps[step]);
  }

  void updateScore(int score, {bool isAgain = false}) {
    if (isAgain) {
      score = kangiSteps[step].scores + score;
    }
    if (score > kangiSteps[step].kangis.length) {
      score = kangiSteps[step].kangis.length;
    }

    kangiSteps[step].scores = score;
    update();
    kangiStepRepositroy.updateKangiStep(kangiSteps[step]);
  }

  KangiStep getJlptStep() {
    return kangiSteps[step];
  }

  void setJlptSteps(String headTitle) {
    this.headTitle = headTitle;
    kangiSteps = kangiStepRepositroy.getKangiStepByHeadTitle(this.headTitle);

    update();
  }
}
