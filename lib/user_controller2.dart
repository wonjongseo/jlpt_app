import 'package:get/get.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/user_repository2.dart';

// ignore: constant_identifier_names
enum TotalProgressType { JLPT, GRAMMAR, KANGI }

class UserController2 extends GetxController {
  UserRepository2 userRepository2 = UserRepository2();
  late User user;

  UserController2() {
    user = userRepository2.getUser();
  }

  void updateCurrentProgress(
      TotalProgressType totalProgressType, int index, int addScore) {
    switch (totalProgressType) {
      case TotalProgressType.JLPT:
        if (user.currentJlptWordScroes[index] + addScore >= 0) {
          user.currentJlptWordScroes[index] += addScore;
        }

        break;
      case TotalProgressType.GRAMMAR:
        if (user.currentGrammarScores[index] + addScore >= 0) {
          user.currentGrammarScores[index] += addScore;
        }

        break;
      case TotalProgressType.KANGI:
        if (user.currentKangiScores[index] + addScore >= 0) {
          user.currentKangiScores[index] += addScore;
        }

        break;
    }
    userRepository2.updateScore(user);
    update();
  }
}
