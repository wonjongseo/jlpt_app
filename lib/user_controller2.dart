import 'package:get/get.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/user_repository2.dart';

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
        user.currentKangiScores[index] += addScore;
        break;
      case TotalProgressType.GRAMMAR:
        user.currentGrammarScores[index] += addScore;
        break;
      case TotalProgressType.KANGI:
        user.currentKangiScores[index] += addScore;
        break;
    }
    update();
  }
}
