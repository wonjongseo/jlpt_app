import 'package:get/get.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import 'package:japanese_voca/entity/jlpt_and_kangi/kangi/repository/kangis_step_repository.dart';

import '../../../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../../../model/Question.dart';
import '../kangi_study/kangi_study_sceen.dart';
import '../../../user/controller/user_controller.dart';

class KangiStepController extends GetxController {
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

  late BannerAdController? bannerAdController;

  void initAdFunction() {
    if (!userController.isUserPremieum()) {
      bannerAdController = Get.find<BannerAdController>();
      if (!bannerAdController!.loadingCalendartBanner) {
        bannerAdController!.loadingCalendartBanner = true;
        bannerAdController!.createCalendarBanner();
      }
    }
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

  bool restrictN1SubStep(
    int subStep,
  ) {
    // 무료버전일 경우.
    if (level == '1' &&
        !userController.isUserPremieum() &&
        subStep > RESTRICT_SUB_STEP_NUM) {
      userController.openPremiumDialog(
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
