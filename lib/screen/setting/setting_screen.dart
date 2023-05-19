import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/project_image_slider.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/localRepository.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

//   int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                bool? alertResult =
                    await getTransparentAlertDialog(contentChildren: [
                  CustomButton(
                      text: 'JLPT 단어', onTap: () => Get.back(result: true)),
                  CustomButton(
                      text: '나만의 단어', onTap: () => Get.back(result: false)),
                ]);

                if (alertResult != null) {
                  if (alertResult == true) {
                    Get.dialog(const AlertDialog(
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        title: ProjectImageSlider(index: 0)));
                  } else {
                    Get.dialog(const AlertDialog(
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        title: ProjectImageSlider(index: 1)));
                  }
                }
              },
              child: const SettingButton(
                text: '앱 설명',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Get.closeAllSnackbars();
                bool isAutoSave = LocalReposotiry.autoSaveOnOff();

                String message = isAutoSave ? 'ON' : 'OFF';

                Get.snackbar(
                  '모름 / 틀림 단어 자동 저장',
                  message,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1),
                  animationDuration: const Duration(seconds: 1),
                );
              },
              child: const SettingButton(
                text: '모름 / 틀림 단어 자동 저장 On / Off',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Get.closeAllSnackbars();
                bool isQuesetionMark = LocalReposotiry.questionMarkOnOff();

                String message = isQuesetionMark ? 'ON' : 'OFF';

                Get.snackbar(
                  '의미 / 읽는법 글자수 표시',
                  message,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1),
                  animationDuration: const Duration(seconds: 1),
                );
              },
              child: const SettingButton(
                text: '의미 / 읽는법 글자수 표시  On / Off',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final alertReulst = await getAlertDialog(
                    const Text('Jlpt 단어를 초기화 하시겠습니까 ?'),
                    const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));

                if (alertReulst != null) {
                  if (alertReulst) {
                    JlptStepRepositroy.deleteAllWord();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '새로고침을 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                }
              },
              child: const SettingButton(
                text: 'Jlpt 초기화 (단어 섞기)',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final alertReulst = await getAlertDialog(
                    const Text('문법을 초기화 하시겠습니까 ?'),
                    const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));

                if (alertReulst != null) {
                  if (alertReulst) {
                    GrammarRepositroy.deleteAllGrammar();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '새로고침을 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                }
              },
              child: const SettingButton(
                text: '문법 초기화 (문법 섞기)',
              ),
            ),
            // const SizedBox(height: 5),
            // InkWell(
            //   onTap: () async {
            //     final alertReulst = await getAlertDialog(
            //         const Text('한자를 초기화 하시겠습니까 ?'),
            //         const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));

            //     if (alertReulst != null) {
            //       if (alertReulst) {
            //         KangiStepRepositroy.deleteAllKangiStep();
            //         KangiStepRepositroy.deleteAllKangi();

            //         Get.closeAllSnackbars();
            //         Get.snackbar(
            //           '초기화 완료!',
            //           '새로고침을 해주세요.',
            //           snackPosition: SnackPosition.BOTTOM,
            //           duration: const Duration(seconds: 2),
            //           animationDuration: const Duration(seconds: 2),
            //         );
            //       }
            //     }
            //   },
            //   child: const SettingButton(
            //     text: '한자 초기화 (한자 섞기)',
            //   ),
            // ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () async {
                final alertReulst = await getAlertDialog(
                    const Text('나만의 단어를 초기화 하시겠습니까 ?'),
                    const Text('되돌릴 수 없습니다, 그래도 진행하시겠습니까?'));

                if (alertReulst != null) {
                  if (alertReulst) {
                    LocalReposotiry.deleteAllMyWord();

                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '새로고침을 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                }
              },
              child: const SettingButton(
                text: '나만의 단어 초기화',
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.5),
          ]),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
