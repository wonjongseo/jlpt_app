import 'package:get/get_state_manager/get_state_manager.dart';

class AnswerController extends GetxController {
  List<int> answerList = List.generate(108, (index) => 0);

  void selectQuestion(int questionIndex, int selectAnswerIndex) {
    answerList[questionIndex] = selectAnswerIndex;
    print('answerList: ${answerList}');
    update();
  }
}
