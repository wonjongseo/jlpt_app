import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

import '../../../../model/Question.dart';

import '../../../../user/controller/user_controller.dart';

class JlptStepController extends GetxController {
  int currChapNumber = 0;

  void toggleAllSave() {
    if (isAllSave()) {
      for (int i = 0; i < getJlptStep().words.length; i++) {
        Word word = getJlptStep().words[i];
        MyWord newMyWord = MyWord.wordToMyWord(word);

        if (isSavedInLocal(word)) {
          MyWordRepository.deleteMyWord(newMyWord);
          userController.updateMyWordSavedCount(false);
        }
      }
    } else {
      for (int i = 0; i < getJlptStep().words.length; i++) {
        Word word = getJlptStep().words[i];
        MyWord newMyWord = MyWord.wordToMyWord(word);

        if (!isSavedInLocal(word)) {
          MyWordRepository.saveMyWord(newMyWord);
          userController.updateMyWordSavedCount(true);
          isWordSaved = true;
        }
      }
    }
    update();
  }

  bool isAllSave() {
    int savedWordCount = 0;
    for (int i = 0; i < getJlptStep().words.length; i++) {
      Word word = getJlptStep().words[i];

      if (isSavedInLocal(word)) {
        savedWordCount++;
      }
    }

    return savedWordCount == getJlptStep().words.length;
  }

  void toggleSeeMean(bool? v) {
    isSeeMean = !v!;
    update();
  }

  void toggleSeeYomikata(bool? v) {
    isSeeYomikata = !v!;
    update();
  }

  bool isSeeMean = true;
  bool isSeeYomikata = true;
  bool isMoreExample = false;

  void onTapMoreExample() {
    isMoreExample = true;
    update();
  }

  Future<void> goToTest({bool isOffAndToName = false}) async {
    // 테스트를 본 적이 있으면.
    if (getJlptStep().wrongQestion != null &&
        getJlptStep().scores != 0 &&
        getJlptStep().scores != getJlptStep().words.length) {
      bool result = await askToWatchMovieAndGetHeart(
        title: const Text('과거의 테스트에서 틀린 문제들이 있습니다.'),
        content: const Text(
          '틀린 문제를 다시 보시겠습니까 ?',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ),
      );
      if (result) {
        // 과거에 틀린 문제로만 테스트 보기.
        // Get.offAndToNamed(page)
        if (isOffAndToName) {
          Get.offAndToNamed(
            JLPT_TEST_PATH,
            arguments: {
              CONTINUTE_JLPT_TEST: getJlptStep().wrongQestion,
            },
          );
        } else {
          Get.toNamed(
            JLPT_TEST_PATH,
            arguments: {
              CONTINUTE_JLPT_TEST: getJlptStep().wrongQestion,
            },
          );
        }
        return;
      }
    }
    if (isOffAndToName) {
      Get.offAndToNamed(
        JLPT_TEST_PATH,
        arguments: {
          JLPT_TEST: getJlptStep().words,
        },
      );
    } else {
      if (getJlptStep().isFinished == null) {
        clearScore();
      } else {
        if (!getJlptStep().isFinished!) {
          clearScore();
        }
      }

      Get.toNamed(
        JLPT_TEST_PATH,
        arguments: {
          JLPT_TEST: getJlptStep().words,
        },
      );
    }
    // 모든 문제로 테스트 보기.
  }

  void onPageChanged(int page) {
    isMoreExample = false;
    update();
    currentIndex = page;

    update();
  }

  bool isWordSaved = false;
  int currentIndex = 0;
  Word getWord() {
    return getJlptStep().words[currentIndex];
  }

  bool isSavedInLocal(Word word) {
    MyWord newMyWord = MyWord.wordToMyWord(word);

    newMyWord.createdAt = DateTime.now();
    isWordSaved = MyWordRepository.savedInMyWordInLocal(newMyWord);

    return isWordSaved;
  }

  void toggleSaveWord(Word word) {
    MyWord newMyWord = MyWord.wordToMyWord(word);
    if (isSavedInLocal(word)) {
      MyWordRepository.deleteMyWord(newMyWord);
      userController.updateMyWordSavedCount(false);

      isWordSaved = false;
    } else {
      MyWordRepository.saveMyWord(newMyWord);
      userController.updateMyWordSavedCount(true);

      isWordSaved = true;
    }
    update();
  }

  List<JlptStep> jlptSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;

  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();
  UserController userController = Get.find<UserController>();

  JlptStepController({required this.level}) {
    headTitleCount = jlptStepRepositroy.getCountByJlptHeadTitle(level);
  }

  void goToStudyPage(int subStep) {
    setStep(subStep);
    Get.toNamed(JLPT_STUDY_PATH);
  }

  void setStep(int step) {
    this.step = step;
  }

  /*
   * 테스트로 만점이면 초기화.
   */
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
    if (score >= jlptSteps[step].words.length) {
      jlptSteps[step].isFinished = true;
    }
    // 에러 발생.
    else if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
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

    currChapNumber =
        LocalReposotiry.getCurrentProgressing('Japaneses-$level-$headTitle');

    setStep(currChapNumber);
    update();
  }

  late PageController pageController;

  void finishQuizAndchangeHeaderPageIndex() {
    int currentHeaderPageIndex =
        LocalReposotiry.getCurrentProgressing('Japaneses-$level-$headTitle');
    if (currentHeaderPageIndex + 1 == jlptSteps.length) {
// TODO

      return;
    }
    step = currentHeaderPageIndex + 1;
    LocalReposotiry.putCurrentProgressing('Japaneses-$level-$headTitle', step);
    pageController.jumpToPage(step);
    // pageController.animateToPage(
    //   step,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeIn,
    // );
  }

  void changeHeaderPageIndex(int index) {
    step = index;
    LocalReposotiry.putCurrentProgressing('Japaneses-$level-$headTitle', step);
    pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void sss() {
    currChapNumber = 3;
    update();
  }
}
