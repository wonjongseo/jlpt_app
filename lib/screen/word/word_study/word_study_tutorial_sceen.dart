import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/word/word_study/word_study_sceen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class WordStudyTutorialSceen extends StatefulWidget {
  const WordStudyTutorialSceen({super.key});

  @override
  State<WordStudyTutorialSceen> createState() => _WordStudyTutorialSceenState();
}

class _WordStudyTutorialSceenState extends State<WordStudyTutorialSceen> {
  List<TargetFocus> targets = [];
  GlobalKey meanKey = GlobalKey();
  GlobalKey yomikataKey = GlobalKey();
  GlobalKey unKnownKey = GlobalKey();
  GlobalKey knownKey = GlobalKey();
  GlobalKey kangiKey = GlobalKey();
  GlobalKey testKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    initTutorial();
  }

  bool isShownYomikata = false;
  bool isShownMean = false;

  void showTutorial() {
    TutorialCoachMark(
      targets: targets,
      onClickTarget: (target) {
        //
      },
      onSkip: () {
        Get.offAndToNamed(WORD_STUDY_PATH);
        // Get.toNamed();
      },
      onFinish: () {
        Get.offAndToNamed(WORD_STUDY_PATH);
        // Get.toNamed(WORD_STUDY_PATH);
      },
    ).show(context: context);
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "kangi",
          keyTarget: kangiKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Text(
                "한자를 클릭하면 [음독, 훈독, 연관 단어] 를 확인 할 수 있습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "mean",
          keyTarget: meanKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Text(
                "[의미] 버튼을 클릭하면 단어의 뜻을 확인할 수 있습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "yomikata",
          keyTarget: yomikataKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Text(
                "[읽는 법] 버튼을 클릭하면 단어의 읽는 법을 확인할 수 있습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "unKnown",
          keyTarget: unKnownKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Text(
                "[몰라요] 버튼을 클릭하면 모르는 단어에 추가되며 모든 단어를 확인 후 한번 더 확인할 수 있습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "known",
          keyTarget: knownKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Text(
                "[알어요] 버튼을 클릭하면 다음 단어로 넘어갈 수 있습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16.0),
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Text.rich(TextSpan(
                    text: "[TEST] 버튼을 클릭하면 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16.0),
                    children: [
                      TextSpan(text: '의미', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 또는 '),
                      TextSpan(
                          text: '읽는법 ', style: TextStyle(color: Colors.red)),
                      TextSpan(text: '으로 테스트를 진행할 수 있습니다 ')
                    ]))),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showTutorial();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: TextButton(
                key: testKey,
                onPressed: () {},
                child: const Text(
                  'TEST',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          title: FAProgressBar(
            currentValue: 40,
            maxValue: 100,
            displayText: '%',
            size: size.width > 500 ? 35 : 25,
            formatValueFixed: 0,
            backgroundColor: AppColors.darkGrey,
            progressColor: AppColors.lightGreen,
            borderRadius: size.width > 500
                ? BorderRadius.circular(30)
                : BorderRadius.circular(12),
            displayTextStyle: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: size.width > 500 ? 18 : 14),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save, size: 22, color: Colors.white),
            ),
          ),
          const Spacer(flex: 1),
          Column(
            children: [
              SizedBox(
                  child: Text('さいきん',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: isShownYomikata
                              ? Colors.white
                              : Colors.transparent))),
              //
              Wrap(
                children: [
                  InkWell(
                    // onTap: () => getDialogKangi(japanese[index], context,
                    //     clickTwice: clickTwice),
                    child: Text(
                      key: kangiKey,
                      '食',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey,
                          color: Colors.white,
                          fontSize: 60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'べる',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                  child: Text('최근',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: isShownMean
                              ? Colors.white
                              : Colors.transparent))),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isShownYomikata)
                    CustomButton(
                      key: meanKey,
                      text: '의미',
                      onTap: () {
                        if (!isShownMean) {}
                      },
                    ),
                  const SizedBox(width: 16),
                  if (!isShownYomikata)
                    CustomButton(
                      key: yomikataKey,
                      text: '읽는 법',
                      onTap: () {
                        if (!isShownYomikata) {
                          // showYomikata();
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    key: unKnownKey,
                    text: '몰라요',
                    onTap: () {
                      // nextWord(false);
                    },
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    key: knownKey,
                    text: '알아요',
                    onTap: () {
                      // nextWord(true);
                    },
                  ),
                ],
              ),
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
