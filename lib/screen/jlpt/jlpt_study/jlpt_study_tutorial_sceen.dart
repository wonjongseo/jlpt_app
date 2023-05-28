import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class JlptStudyTutorialSceen extends StatefulWidget {
  const JlptStudyTutorialSceen({super.key});

  @override
  State<JlptStudyTutorialSceen> createState() => _JlptStudyTutorialSceenState();
}

class _JlptStudyTutorialSceenState extends State<JlptStudyTutorialSceen> {
  List<TargetFocus> targets = [];
  GlobalKey meanKey = GlobalKey();
  GlobalKey yomikataKey = GlobalKey();
  GlobalKey unKnownKey = GlobalKey();
  GlobalKey knownKey = GlobalKey();
  GlobalKey kangiKey = GlobalKey();
  GlobalKey testKey = GlobalKey();
  GlobalKey saveKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    initTutorial();
  }

  bool isShownYomikata = false;
  bool isShownMean = false;

  void showTutorial() {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'kangi') {}
      },
      onSkip: () {
        Get.offAndToNamed(JLPT_STUDY_PATH);
        // Get.toNamed();
      },
      onFinish: () {
        Get.offAndToNamed(JLPT_STUDY_PATH);
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
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '한자 정보 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '한자', style: TextStyle(color: Colors.red)),
                          TextSpan(text: '를 클릭하여 '),
                          TextSpan(
                              text: '음독', style: TextStyle(color: Colors.red)),
                          TextSpan(text: ', '),
                          TextSpan(
                              text: '훈독', style: TextStyle(color: Colors.red)),
                          TextSpan(text: ', '),
                          TextSpan(
                              text: '연관 단어',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: ', '),
                          TextSpan(text: '를 확인 할 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "mean",
          keyTarget: meanKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                // child: const TutorialText(
                //   title: '일본어 의미 보기',
                //   subTitles: ['[의미] 버튼을 눌러서 의미를 확인 할 수 있습니다.'],
                // ),

                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '일본어 의미 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '의미', style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 버튼을 눌러서 의미를 확인 할 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "yomikata",
          keyTarget: yomikataKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                // child: const TutorialText(
                //   title: '일본어 읽는 법 보기',
                //   subTitles: ['[읽는 법] 버튼을 눌러서 읽는 법을 확인 할 수 있습니다.'],
                // ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '일본어 읽는 법 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '읽는 법 ',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 버튼을 눌러서 의미를 확인 할 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "unKnown",
          keyTarget: unKnownKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                // child: const TutorialText(
                //   title: '단어 한번 더 보기',
                //   subTitles: ['[몰라요] 버튼을 눌러서 해당 단어를 한번 더 확인 할 수 있습니다.'],
                // ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 한번 더 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '몰라요 ',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 버튼을 눌러서 해당 단어를 한번 더 확인 할 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "known",
          keyTarget: knownKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                // child: const TutorialText(
                //   title: '단어 넘어가기',
                //   subTitles: ['[알아요] 버튼을 눌러서 다음 단어로 넘어갈 수 있습니다.'],
                // ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 넘어가기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '알아요 ',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 버튼을 눌러서 다음 단어로 넘어갈 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                // child: const TutorialText(
                //   title: '단어 테스트 하기',
                //   subTitles: ['[의미] 또는 [읽는 법] 으로 해당 페이지의 단어를 테스트 할 수 있습니다.'],
                // ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 테스트 하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "[TEST] 버튼을 클릭하면 ",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '의미', style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 또는 '),
                          TextSpan(
                              text: '읽는법 ',
                              style: TextStyle(color: Colors.red)),
                          TextSpan(text: '으로 테스트를 진행할 수 있습니다 ')
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        TargetFocus(
          identify: "save",
          keyTarget: saveKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const TutorialText(
                  title: '[나만의 단어] 에 단어 저장',
                  subTitles: ['설정 페이지에서 [자동 저장] 을 통해 [ON / OFF] 설정을 할 수 합니다'],
                ))
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
              icon: Icon(
                Icons.save,
                key: saveKey,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(flex: 1),
          Column(
            children: [
              SizedBox(
                  child: Text('たべる',
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
                    onTap: () =>
                        getDialogKangi('食', context, clickTwice: false),
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
                  child: Text('먹다',
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
