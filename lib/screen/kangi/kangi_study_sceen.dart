import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/screen/kangi/components/kangi_related_card.dart';
import 'package:japanese_voca/controller/kangi_study_controller.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/local_repository.dart';

import '../../common/widget/app_bar_progress_bar.dart';

final String KANGI_STUDY_PATH = '/kangi_study';
final String IS_TEST_AGAIN = 'isTestAgain';

// ignore: must_be_immutable
class KangiStudySceen extends StatelessWidget {
  KangiStudySceen({super.key}) {
    if (Get.arguments != null && Get.arguments[IS_TEST_AGAIN] != null) {
      Get.put(KangiStudyController(isAgainTest: true));
    } else {
      Get.put(KangiStudyController());
    }
  }

  KangiController kangiController = Get.find<KangiController>();

  bool isAutoSave = LocalReposotiry.getAutoSave();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<KangiStudyController>(builder: (controller) {
      double currentValue = ((controller.currentIndex).toDouble() /
              controller.kangis.length.toDouble()) *
          100;

      return Scaffold(
        appBar: AppBar(
          title: AppBarProgressBar(
            size: size,
            currentValue: currentValue,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await controller.goToTest();
                return;
              },
              child: const Text(
                'TEST',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isAutoSave)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Word currentWord = Word(
                        word: controller.kangis[controller.currentIndex].japan,
                        mean: controller.kangis[controller.currentIndex].korea,
                        yomikata:
                            '${controller.kangis[controller.currentIndex].undoc} / ${controller.kangis[controller.currentIndex].hundoc}',
                        headTitle: '');
                    MyWord.saveToMyVoca(currentWord, isManualSave: true);
                  },
                  icon: const Icon(Icons.save, size: 22, color: Colors.white),
                ),
              )
            else
              const SizedBox(height: 20),
            const Spacer(),
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.kangis.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ZoomIn(
                        duration: const Duration(milliseconds: 300),
                        animate: controller.isShownKorea,
                        child: Text(
                          controller.kangis[index].korea,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: controller.isShownKorea
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            content: KangiRelatedCard(
                              kangi: controller.kangis[controller.currentIndex],
                            ),
                          ));
                        },
                        child: Text(
                          controller.kangis[index].japan,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 65,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  '음독 :  ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  '훈독 :  ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ZoomIn(
                                  animate: controller.isShownUndoc,
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    controller.kangis[index].undoc,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: controller.isShownUndoc
                                          ? Colors.white
                                          : Colors.transparent,
                                    ),
                                  ),
                                ),
                                ZoomIn(
                                  animate: controller.isShownHundoc,
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    controller.kangis[index].hundoc,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: controller.isShownHundoc
                                          ? Colors.white
                                          : Colors.transparent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomOut(
                      animate: controller.isShownKorea,
                      child: KangiButton(
                        text: '한자',
                        onTap: controller.showYomikata,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ZoomOut(
                      animate: controller.isShownUndoc,
                      duration: const Duration(milliseconds: 300),
                      child: KangiButton(
                        text: '음독',
                        onTap: controller.showUndoc,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ZoomOut(
                      animate: controller.isShownHundoc,
                      child: KangiButton(
                        text: '훈독',
                        onTap: controller.showHundoc,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KangiButton(
                      text: '몰라요',
                      onTap: () => controller.nextWord(false),
                    ),
                    const SizedBox(width: 10),
                    KangiButton(
                      text: '알아요',
                      onTap: () => controller.nextWord(true),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      );
    });
  }
}

class KangiButton extends StatelessWidget {
  const KangiButton({
    super.key,
    this.width = 95,
    this.height = 40,
    required this.text,
    required this.onTap,
  });

  final double height;
  final double width;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}