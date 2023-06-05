import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import 'package:japanese_voca/repository/kangis_step_repository.dart';

import '../model/Question.dart';

class KangiController extends GetxController {
  List<KangiStep> kangiSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;

  KangiStepRepositroy kangiStepRepository = KangiStepRepositroy();

  KangiController({required this.level}) {
    headTitleCount = kangiStepRepository.getCountByHangul(level);
  }

  void setStep(int step) {
    this.step = step;

    if (kangiSteps[step].scores == kangiSteps[step].kangis.length) {
      clearScore();
    }
  }

  void clearScore() {
    kangiSteps[step].scores = 0;
    update();
    kangiStepRepository.updateKangiStep(level, kangiSteps[step]);
  }

  void updateScore(int score, List<Question> wrongQestion) {
    score = score + kangiSteps[step].scores;

    if (score > kangiSteps[step].kangis.length) {
      score = kangiSteps[step].kangis.length;
    }
    kangiSteps[step].scores = score;

    if (score == kangiSteps[step].kangis.length) {
      kangiSteps[step].isFinished = true;
    }

    kangiSteps[step].wrongQuestion = wrongQestion;
    update();
    kangiStepRepository.updateKangiStep(level, kangiSteps[step]);
  }

  KangiStep getKangiStep() {
    return kangiSteps[step];
  }

  void setKangiSteps(String headTitle) {
    this.headTitle = headTitle;
    kangiSteps =
        kangiStepRepository.getKangiStepByHeadTitle(level, this.headTitle);

    update();
  }
}
