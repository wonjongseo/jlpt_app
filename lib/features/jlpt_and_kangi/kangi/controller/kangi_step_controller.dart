import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/kangi_test/kangi_test_screen.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/model/my_word.dart';

import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

import '../../../../common/app_constant.dart';
import '../../../../model/Question.dart';
import '../../../kangi_study/screens/kangi_study_sceen.dart';
import '../../../../user/controller/user_controller.dart';

class KangiStepController extends GetxController {
  void toggleAllSave() {
    if (isAllSave()) {
      for (int i = 0; i < getKangiStep().kangis.length; i++) {
        Kangi kangi = getKangiStep().kangis[i];
        MyWord newMyWord = MyWord.kangiToMyWord(kangi);

        if (isSavedInLocal(kangi)) {
          MyWordRepository.deleteMyWord(newMyWord);
          savedWordCount--;
        }
      }
      // isAllSave = false;
    } else {
      for (int i = 0; i < getKangiStep().kangis.length; i++) {
        Kangi kangi = getKangiStep().kangis[i];

        MyWord newMyWord = MyWord.kangiToMyWord(kangi);

        if (!isSavedInLocal(kangi)) {
          MyWordRepository.saveMyWord(newMyWord);
          isWordSaved = true;
          savedWordCount++;
        }
      }

      // isAllSave = true;
    }
    print('savedWordCount : ${savedWordCount}');
    update();
  }

  bool isAllSave() {
    // return true;
    return savedWordCount == getKangiStep().kangis.length;
  }

  void toggleSeeMean(bool? v) {
    isHidenMean = v!;
    update();
  }

  void toggleSeeUndoc(bool? v) {
    isHidenUndoc = v!;
    update();
  }

  void toggleSeeHundoc(bool? v) {
    isHidenHundoc = v!;
    update();
  }

  bool isHidenMean = false;
  bool isHidenUndoc = false;
  bool isHidenHundoc = false;

  void onPageChanged(int page) {
    currentIndex = page;
    isWordSaved = false;
    update();
  }

  bool isWordSaved = false;
  bool isSavedInLocal(Kangi kangi) {
    MyWord newMyWord = MyWord.kangiToMyWord(kangi);

    newMyWord.createdAt = DateTime.now();
    isWordSaved = MyWordRepository.savedInMyWordInLocal(newMyWord);
    return isWordSaved;
  }

  int savedWordCount = 0;
  void toggleSaveWord(Kangi kangi) {
    MyWord newMyWord = MyWord.kangiToMyWord(kangi);
    if (isSavedInLocal(kangi)) {
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

  Future<void> goToTest() async {
    if (getKangiStep().wrongQuestion != null &&
        getKangiStep().scores != 0 &&
        getKangiStep().scores != getKangiStep().kangis.length) {
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
          KANGI_TEST_PATH,
          arguments: {
            CONTINUTE_KANGI_TEST: getKangiStep().wrongQuestion,
          },
        );
        return;
      }
    }
    Get.toNamed(
      KANGI_TEST_PATH,
      arguments: {
        KANGI_TEST: getKangiStep().kangis,
      },
    );
  }

  int currentIndex = 0;
  Kangi getWord() {
    return getKangiStep().kangis[currentIndex];
  }

  List<KangiStep> kangiSteps = [];
  final String level;
  late String headTitle;
  late int headTitleCount;
  late int step;

  KangiStepRepositroy kangiStepRepository = KangiStepRepositroy();
  UserController userController = Get.find<UserController>();

  KangiStepController({required this.level}) {
    headTitleCount = kangiStepRepository.getCountByHangul(level);
  }

  void setStep(int step) {
    this.step = step;

    if (kangiSteps[step].scores == kangiSteps[step].kangis.length) {
      // clearScore();
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

  bool restrictN1SubStep(
    int subStep,
  ) {
    // 무료버전일 경우.
    if (level == '1' &&
        !userController.isUserPremieum() &&
        subStep > AppConstant.RESTRICT_SUB_STEP_INDEX) {
      userController.openPremiumDialog('N1급 모든 단어 활성화',
          messages: ['N1 한자의 다른 챕터에서 무료버전의 일부를 학습 할 수 있습니다.']);
      return true;
    }
    return false;
  }

  void goToStudyPage(int subStep) {
    setStep(subStep);
    Get.toNamed(KANGI_STUDY_PATH);
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
