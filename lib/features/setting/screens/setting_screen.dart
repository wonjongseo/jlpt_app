import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../services/setting_controller.dart';
import '../widgets/setting_button.dart';
import '../widgets/setting_switch.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find<SettingController>();
    bool isSettingPage = Get.arguments['isSettingPage'];
    // ignore: deprecated_member_use
    return WillPopScope(
      child: Scaffold(
        appBar: _appBar(settingController, isSettingPage),
        body: _body(settingController.userController, isSettingPage),
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

  SingleChildScrollView _body(
      UserController userController, bool isSettingPage) {
    return SingleChildScrollView(
      child: Center(
        child: GetBuilder<SettingController>(
          builder: (settingController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isSettingPage) ...[
                  SettingSwitch(
                    isOn: settingController.isTestKeyBoard,
                    onChanged: (value) => settingController.flipTestKeyBoard(),
                    text: 'JLPT단어 테스트 키보드 활성화',
                  ),
                  const Divider(),
                  GetBuilder<UserController>(builder: (controller) {
                    return Column(
                      children: [
                        SoundSettingSlider(
                          activeColor: Colors.redAccent,
                          option: '음량',
                          value: userController.volumn,
                          label: '음량: ${userController.volumn}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.VOLUMN, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.VOLUMN, value);
                          },
                        ),
                        SoundSettingSlider(
                          activeColor: Colors.blueAccent,
                          option: '음조',
                          value: userController.pitch,
                          label: '음조: ${userController.pitch}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.PITCH, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.PITCH, value);
                          },
                        ),
                        SoundSettingSlider(
                          activeColor: Colors.deepPurpleAccent,
                          option: '속도',
                          value: userController.rate,
                          label: '속도: ${userController.rate}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.RATE, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.RATE, value);
                          },
                        ),
                      ],
                    );
                  }),
                ] else ...[
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
                ]
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(SettingController settingController, bool isSettingPage) {
    return AppBar(
      title: Text(isSettingPage ? '설정' : '데이터 초기화'),
    );
  }
}

class SoundSettingSlider extends StatelessWidget {
  const SoundSettingSlider({
    super.key,
    required this.value,
    required this.option,
    required this.label,
    required this.activeColor,
    required this.onChangeEnd,
    required this.onChanged,
  });

  final double value;
  final String option;
  final String label;
  final Color activeColor;
  final Function(double) onChangeEnd;
  final Function(double) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(option),
          Expanded(
            child: Slider(
              value: value,
              onChangeEnd: (v) {
                onChangeEnd(v);
              },
              onChanged: onChanged,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              activeColor: activeColor,
              label: label,
            ),
          )
        ],
      ),
    );
  }
}
