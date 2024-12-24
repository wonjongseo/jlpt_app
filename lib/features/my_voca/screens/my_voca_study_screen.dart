import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/custom_appbar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/model/word.dart';

class MyVocaStduySCreen extends StatefulWidget {
  const MyVocaStduySCreen({super.key, required this.index});
  final int index;
  @override
  State<MyVocaStduySCreen> createState() => _MyVocaStduySCreenState();
}

class _MyVocaStduySCreenState extends State<MyVocaStduySCreen> {
  late PageController pageController;

  MyVocaController controller = Get.find<MyVocaController>();
  TtsController ttsController = Get.find<TtsController>();
  @override
  void initState() {
    controller.currentIndex = widget.index;
    pageController = PageController(initialPage: controller.currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyVocaController>(builder: (controller) {
      int wordsLen = controller.selectedWord.length;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(appBarHeight),
          child: AppBar(
            title: wordsLen == controller.currentIndex
                ? null
                : CustomAppBarTitle(
                    curIndex: controller.currentIndex + 1,
                    totalIndex: controller.selectedWord.length,
                  ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) async {
                await ttsController.stop();
                controller.onPageChanged(value);
              },
              itemCount: wordsLen >= 4 ? wordsLen + 1 : wordsLen,
              itemBuilder: (context, index) {
                if (wordsLen == index && wordsLen >= 4) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Responsive.height16 * 2,
                        horizontal: Responsive.width16),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          JLPT_TEST_PATH,
                          arguments: {MY_VOCA_TEST: controller.selectedWord},
                        );
                      },
                      child: Card(
                        child: Center(
                          child: Text(
                            '퀴즈 풀러 가기!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan.shade600,
                                fontSize: Responsive.height10 * 2.4),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return WordCard(
                  myWordIcon: Padding(
                    padding: EdgeInsets.only(left: Responsive.height16 / 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Responsive.height10 * 3,
                              child: Checkbox(
                                  activeColor: AppColors.mainBordColor,
                                  value: controller.selectedWord[index].isKnown,
                                  onChanged: (v) {
                                    if (controller
                                        .selectedWord[index].isKnown) {
                                      controller.updateWord(
                                          controller.selectedWord[index].word,
                                          false);
                                    } else {
                                      controller.updateWord(
                                          controller.selectedWord[index].word,
                                          true);
                                    }
                                  }),
                            ),
                            if (controller.selectedWord[index].isKnown)
                              Text(
                                '암기',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainBordColor,
                                ),
                              )
                            else
                              const Text('미암기')
                          ],
                        ),
                        SizedBox(width: Responsive.width10),
                        InkWell(
                          onTap: () {
                            controller.deleteWord(
                              controller.selectedWord[controller.currentIndex],
                              isYokumatiageruWord:
                                  !controller.isManualSavedWordPage,
                            );
                            int curSelectWordLen =
                                controller.selectedWord.length;
                            if (curSelectWordLen == 0) {
                              return Get.back();
                            } else {
                              Get.off(
                                () => MyVocaStduySCreen(
                                  index: controller.currentIndex,
                                ),
                                preventDuplicates: false,
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Responsive.width10 / 2),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Responsive.height10 * 3,
                                  child: Icon(Icons.delete),
                                ),
                                const Text(
                                  '삭제',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  word: Word.myWordToWord(controller.selectedWord[index]),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }
}
