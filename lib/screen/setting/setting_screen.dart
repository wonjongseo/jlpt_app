import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_controller.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'services/setting_controller.dart';
import 'components/setting_button.dart';
import 'components/setting_switch.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find<SettingController>();

    return Scaffold(
      appBar: _appBar(),
      body: _body(settingController.userController),
      bottomNavigationBar: _bottomNavigationBar(),
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
                  text: 'JLPT단어 테스트의 읽는 법 키보드 표시',
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
                const SizedBox(height: 5),
                SettingButton(
                  text: '앱 설명 보기',
                  onPressed: () => settingController.initGrammar(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('설정'),
      elevation: 0,
      leading: const BackButton(color: Colors.white),
    );
  }

  GetBuilder<BannerAdController> _bottomNavigationBar() {
    return GetBuilder<BannerAdController>(
      builder: (controller) {
        return BannerContainer(bannerAd: controller.settingBanner);
      },
    );
  }
}
