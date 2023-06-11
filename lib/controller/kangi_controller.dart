import 'package:get/get.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import 'package:japanese_voca/repository/kangis_step_repository.dart';

import '../model/Question.dart';
import 'user_controller.dart';

class KangiController extends GetxController {
  List<KangiStep> kangiSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;

  KangiStepRepositroy kangiStepRepository = KangiStepRepositroy();
  UserController userController = Get.find<UserController>();

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
    int score = kangiSteps[step].scores;
    kangiSteps[step].scores = 0;
    update();
    kangiStepRepository.updateKangiStep(level, kangiSteps[step]);
    userController.updateCurrentProgress(
        TotalProgressType.KANGI, int.parse(level) - 1, -score);
  }

  void updateScore(int score, List<Question> wrongQestion) {
    int previousScore = kangiSteps[step].scores;

    if (previousScore != 0) {
      userController.updateCurrentProgress(
          TotalProgressType.KANGI, int.parse(level) - 1, -previousScore);
    }

    score = score + previousScore;

    if (score >= kangiSteps[step].kangis.length) {
      kangiSteps[step].isFinished = true;
    } else if (score > kangiSteps[step].kangis.length) {
      score = kangiSteps[step].kangis.length;
    }

    kangiSteps[step].wrongQuestion = wrongQestion;
    kangiSteps[step].scores = score;

    update();
    kangiStepRepository.updateKangiStep(level, kangiSteps[step]);
    userController.updateCurrentProgress(
        TotalProgressType.KANGI, int.parse(level) - 1, score);
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
