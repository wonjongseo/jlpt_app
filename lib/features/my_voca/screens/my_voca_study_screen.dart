import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
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
            title: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: appBarTextSize),
                children: [
                  TextSpan(
                    text: '${controller.currentIndex + 1}',
                    style: TextStyle(
                      color: Colors.cyan.shade500,
                      fontSize: Responsive.height10 * 2.5,
                    ),
                  ),
                  const TextSpan(text: ' / '),
                  TextSpan(text: '${controller.selectedWord.length}')
                ],
              ),
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
              itemCount: wordsLen + 1,
              itemBuilder: (context, index) {
                if (wordsLen == index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 16),
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
                    word: Word.myWordToWord(controller.selectedWord[index]));
              },
            ),
          ),
        ),
        bottomNavigationBar: const GlobalBannerAdmob(),
      );
    });
  }
}
