import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import 'package:japanese_voca/repository/kangis_step_repository.dart';

import '../model/Question.dart';

class KangiController extends GetxController {
  List<List<KangiStep>> allJlpt = [];

  List<KangiStep> kangiSteps = [];
  final String hangul;
  late int headTitleCount;
  late int step;
  KangiStepRepositroy kangiStepRepository = KangiStepRepositroy();

  KangiController({required this.hangul}) {
    headTitleCount = kangiStepRepository.getCountByHangul(hangul);
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
    kangiStepRepository.updateKangiStep(kangiSteps[step]);
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
    kangiStepRepository.updateKangiStep(kangiSteps[step]);
  }

  KangiStep getKangiStep() {
    return kangiSteps[step];
  }

  void setKangiSteps(String hangul) {
    kangiSteps = kangiStepRepository.getKangiStepByHeadTitle(this.hangul);

    update();
  }
}
