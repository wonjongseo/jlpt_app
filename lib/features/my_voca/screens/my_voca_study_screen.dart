import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
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
      int wordsLen = controller.myWords.length;

      return Scaffold(
        appBar: AppBar(
          title: Text(
              '${controller.currentIndex + 1} / ${controller.myWords.length}'),
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
                          arguments: {MY_VOCA_TEST: controller.myWords},
                        );
                      },
                      child: Card(
                        child: Center(
                          child: Text(
                            'Go to the QUIZ!',
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
                  word: Word.myWordToWord(controller.myWords[index]),
                  // controller: controller,
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
