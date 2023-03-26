import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/Images.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/project_image_slider.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

//   int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                JlptStepRepositroy.deleteAllWord();
                Get.closeAllSnackbars();
                Get.snackbar(
                  '초기화 완료!',
                  '새로고침을 해주세요.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  animationDuration: const Duration(seconds: 2),
                );
              },
              child: const SettingButton(
                text: 'Jlpt 초기화 (단어 섞기)',
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                getTransparentAlertDialog(contentChildren: [
                  CustomButton(
                      text: 'JLPT 단어',
                      onTap: () {
                        Get.back();

                        Get.dialog(AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 2),
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          // title: const Text('Jlpt 단어'),
                          title: StatefulBuilder(builder: (context, setState) {
                            int currentIndex = 0;
                            CarouselController carouselController =
                                CarouselController();
                            ProjectImage projectImage = ProjectImage();
                            void changeIndexOfSlider(int newIndex) {
                              setState(() {
                                currentIndex = newIndex;
                              });
                            }

                            return ProjectImageSlider(
                                carouselController: carouselController,
                                setState: changeIndexOfSlider,
                                projectImage: projectImage,
                                currentIndex: currentIndex);
                          }),
                        ));
                      }),
                  CustomButton(text: '나만의 단어', onTap: () {})
                ]);
              },
              child: const SettingButton(
                text: '앱 설명',
              ),
            ),
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
