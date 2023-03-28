import 'package:get/get.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';

class GrammarController extends GetxController {
  List<GrammarStep> grammers = [];
  late int step;
  late String level;
  GrammarRepositroy grammarRepositroy = GrammarRepositroy();
  void setStep(int step) {
    this.step = step;

    if (grammers[step].scores == grammers[step].grammars.length) {
      clearScore();
    }
  }

  void clearScore() {
    grammers[step].scores = 0;
    update();
    grammarRepositroy.updateGrammerStep(grammers[step]);
  }

  void updateScore(int score, {bool isAgain = false}) {
    if (isAgain) {
      score = grammers[step].scores + score;
    }
    // if (jlptSteps[step].scores > score) {
    //   return;
    // }
    if (score > grammers[step].grammars.length) {
      score = grammers[step].grammars.length;
    }

    grammers[step].scores = score;
    update();
    grammarRepositroy.updateGrammerStep(grammers[step]);
  }

  GrammarStep getGrammarStep() {
    return grammers[step];
  }

  void setGrammarSteps(String level) {
    this.level = level;
    grammers = grammarRepositroy.getGrammarStepByLevel(this.level);

    update();
  }
}
