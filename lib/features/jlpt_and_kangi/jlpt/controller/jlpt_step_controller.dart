import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_tutorial_sceen.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

import '../../../../common/app_constant.dart';
import '../../../../model/Question.dart';

import '../../../../user/controller/user_controller.dart';

class JlptStepController extends GetxController {
  Future<void> goToTest() async {
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
        Get.toNamed(
          JLPT_TEST_PATH,
          arguments: {
            CONTINUTE_JLPT_TEST: getJlptStep().wrongQestion,
          },
        );
      }
    }

    // 모든 문제로 테스트 보기.
    Get.toNamed(
      JLPT_TEST_PATH,
      arguments: {
        JLPT_TEST: getJlptStep().words,
      },
    );
  }

  void onPageChanged(int page) {
    currentIndex = page;

    update();
  }

  bool isWordSaved = false;
  int currentIndex = 0;
  Word getWord() {
    return getJlptStep().words[currentIndex];
  }

  int savedWordCount = 0;

  bool isSavedInLocal() {
    MyWord newMyWord = MyWord.wordToMyWord(getWord());

    newMyWord.createdAt = DateTime.now();
    isWordSaved = MyWordRepository.savedInMyWordInLocal(newMyWord);
    return isWordSaved;
  }

  void toggleSaveWord() {
    print('currentIndex : ${currentIndex}');

    MyWord newMyWord = MyWord.wordToMyWord(getWord());
    if (isSavedInLocal()) {
      MyWordRepository.deleteMyWord(newMyWord);
      isWordSaved = false;
      savedWordCount--;
    } else {
      MyWordRepository.saveMyWord(newMyWord);
      isWordSaved = true;
      savedWordCount++;
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

  @override
  void onClose() {
    userController.updateCountYokumatigaeruWord(savedWordCount);
    super.onClose();
  }

  bool restrictN1SubStep(int subStep) {
    if (userController.user.isFake) {
      return false;
    }
    // 무료버전일 경우.
    if ((level == '1' &&
        !userController.isUserPremieum() &&
        subStep > AppConstant.RESTRICT_SUB_STEP_INDEX)) {
      userController.openPremiumDialog('N1급 모든 단어 활성화',
          messages: ['N1 단어의 다른 챕터에서 무료버전의 일부를 학습 할 수 있습니다.']);
      return true;
    }
    return false;
  }

  void goToStudyPage(int subStep
      // bool isSeenTutorial
      ) {
    setStep(subStep);
    // if (isSeenTutorial) {
    Get.toNamed(JLPT_STUDY_PATH);
    // } else {
    //   isSeenTutorial = true;
    //   Get.to(
    //     () => const JlptStudyTutorialSceen(),
    //     transition: Transition.circularReveal,
    //   );
    // }
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
    if (score == jlptSteps[step].words.length) {
      jlptSteps[step].isFinished = true;
    }
    // 에러 발생.
    else if (score > jlptSteps[step].words.length) {
      score = jlptSteps[step].words.length;
    }

    if (jlptSteps[step].wrongQestion != null) {
      for (int i = 0; i < jlptSteps[step].wrongQestion!.length; i++) {
        for (int j = 0; j < wrongQestion.length; j++) {
          if (jlptSteps[step].wrongQestion![i] == wrongQestion[j]) {}
        }
      }
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

    update();
  }
}
