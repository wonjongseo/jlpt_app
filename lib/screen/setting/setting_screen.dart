import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/repository/local_repository.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';
import '../../common/admob/banner_ad/global_banner_admob.dart';
import 'services/setting_controller.dart';
import 'components/setting_button.dart';
import 'components/setting_switch.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find<SettingController>();

    return WillPopScope(
      child: Scaffold(
        appBar: _appBar(settingController),
        body: _body(settingController.userController),
        bottomNavigationBar: const GlobalBannerAdmob(),
      ),
      onWillPop: () async {
        if (settingController.isInitial) {
          Get.dialog(const AlertDialog(
            content: Text(
              '앱을 종료 후 다시 켜주세요.',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ));
        }
        return true;
      },
    );
  }

  SingleChildScrollView _body(UserController userController) {
    return SingleChildScrollView(
      child: Center(
        child: GetBuilder<SettingController>(
          builder: (settingController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SettingSwitch(
                  isOn: settingController.isAutoSave,
                  onChanged: (value) => settingController.flipAutoSave(),
                  text: '모름 / 틀림 단어 자동 저장',
                ),
                SettingSwitch(
                  isOn: settingController.isTestKeyBoard,
                  onChanged: (value) => settingController.flipTestKeyBoard(),
                  text: 'JLPT단어 테스트 키보드 활성화',
                ),
                SettingButton(
                  onPressed: () => settingController.initJlptWord(),
                  text: 'Jlpt 초기화 (단어 섞기)',
                ),
                SettingButton(
                  onPressed: () => settingController.initGrammar(),
                  text: '문법 초기화 (문법 섞기)',
                ),
                SettingButton(
                  onPressed: () => settingController.initkangi(),
                  text: '한자 초기화 (한자 섞기)',
                ),
                SettingButton(
                  text: '나만의 단어 초기화',
                  onPressed: () => settingController.initMyWords(),
                ),
                SettingButton(
                  text: '앱 설명 보기',
                  onPressed: () => settingController.initAppDescription(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(SettingController settingController) {
    return AppBar(
      title: const Text('설정'),
      actions: [
        InkWell(
          onLongPress: () async {
            settingController.userController.user.isFake =
                !settingController.userController.user.isFake;
            await askToWatchMovieAndGetHeart(
                title: const Text('모드 변경'),
                content: Text(
                  settingController.userController.user.isFake == true
                      ? 'Fake으로 변경 되었습니다.'
                      : 'UnFake으로 변경 되었습니다.',
                  style: const TextStyle(color: AppColors.scaffoldBackground),
                ));
          },
          child: Container(width: 30, height: 30),
        ),
      ],
    );
  }
}
