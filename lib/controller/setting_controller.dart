import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../repository/local_repository.dart';

class SettingController extends GetxController {
  bool isAutoSave = LocalReposotiry.getAutoSave();
  // bool isQuesetionMark = LocalReposotiry.getquestionMark();
  bool isTestKeyBoard = LocalReposotiry.getTestKeyBoard();

  bool toggleAutoSave() {
    isAutoSave = !isAutoSave;
    LocalReposotiry.autoSaveOnOff();
    update();
    return isAutoSave;
  }

  // bool toggleQuesetionMark() {
  //   isQuesetionMark = !isQuesetionMark;
  //   LocalReposotiry.questionMarkOnOff();
  //   update();
  //   return isQuesetionMark;
  // }

  bool settingController() {
    isTestKeyBoard = !isTestKeyBoard;
    LocalReposotiry.testKeyBoardOnfOFF();
    update();
    return isTestKeyBoard;
  }
}
