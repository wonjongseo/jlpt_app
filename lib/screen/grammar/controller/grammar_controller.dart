import 'package:get/get.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';

import '../../../user_controller2.dart';

class GrammarController extends GetxController {
  List<GrammarStep> grammers = [];
  late int step;
  late String level;
  GrammarRepositroy grammarRepositroy = GrammarRepositroy();

  UserController2 userController2 = Get.find<UserController2>();

  GrammarController({required this.level}) {
    grammers = grammarRepositroy.getGrammarStepByLevel(level);
  }

  void setStep(int step) {
    this.step = step;

    if (grammers[step].scores == grammers[step].grammars.length) {
      clearScore();
    }
  }

  void clearScore() {
    int subtrackScore = grammers[step].scores;
    grammers[step].scores = 0;
    update();
    grammarRepositroy.updateGrammerStep(grammers[step]);
    userController2.updateCurrentProgress(
        TotalProgressType.GRAMMAR, int.parse(level) - 1, -subtrackScore);
  }

  void updateScore(int score) {
    score = score + grammers[step].scores;

    if (score > grammers[step].grammars.length) {
      score = grammers[step].grammars.length;
    }
    grammers[step].scores = score;

    if (score == grammers[step].grammars.length) {
      grammers[step].isFinished = true;
    }

    update();
    grammarRepositroy.updateGrammerStep(grammers[step]);
    userController2.updateCurrentProgress(
        TotalProgressType.GRAMMAR, int.parse(level) - 1, score);
  }

  GrammarStep getGrammarStep() {
    return grammers[step];
  }

  void setGrammarSteps(String level) {
    this.level = level;

    update();
  }
}
