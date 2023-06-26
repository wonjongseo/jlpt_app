import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/kangi/kangi_study/kangi_button.dart';
import 'package:japanese_voca/screen/jlpt_and_kangi/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../common/widget/app_bar_progress_bar.dart';
import '../../../../config/colors.dart';

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
  GlobalKey heartKey = GlobalKey();
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
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'kangi') {}
      },
      onSkip: () {
        Get.offAndToNamed(JLPT_STUDY_PATH);
      },
      onFinish: () {
        Get.offAndToNamed(JLPT_STUDY_PATH);
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
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '한자',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: '를 클릭하여 '),
                          TextSpan(
                              text: '읽는 법, 음독, 훈독',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(
                              text: '+ 연관 단어',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
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
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '일본어 의미 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '의미',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
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
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '일본어 읽는 법 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '읽는 법',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
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
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 한번 더 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '몰라요',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 버튼을 눌러서 해당 단어를 '),
                          TextSpan(
                              text: '한번 더',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 확인 할 수 있습니다.')
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
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 넘어가기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '알아요',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 버튼을 눌러서 다음 단어로 넘어갈 수 있습니다.')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "heart",
          keyTarget: heartKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '하트',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    const Text.rich(
                      TextSpan(
                        text: '1. ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '한자의 설명',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: '을 보기 위해서는 '),
                          TextSpan(
                              text: '하트',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(
                            text: '가 필요합니다.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimentions.height10),
                    const Text.rich(
                      TextSpan(
                        text: '2. ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '테스트',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: '를 통해 '),
                          TextSpan(
                              text: '하트',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(
                            text: '를 채울 수 있습니다. ',
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단어 테스트 하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "1. 시험보기 버튼을 클릭하면 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '읽는 법',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 과 '),
                          TextSpan(
                              text: '의미',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: '로 테스트를 진행할 수 있습니다 ')
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '2. 읽는 법',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 은 주관식이며 '),
                          TextSpan(
                              text: '설정 페이지',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: ' 에서 OFF 할 수 있습니다.'),
                          TextSpan(
                            text: ' (장음은 입력하지 않아도 됨)',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          )
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
                title: '[자주 틀리는 단어장] 에 단어 저장',
              ),
            )
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
            Stack(
              key: heartKey,
              alignment: AlignmentDirectional.center,
              children: const [
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 40,
                ),
                Text(
                  '30',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
          title: AppBarProgressBar(
            size: size,
            currentValue: 40,
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  key: saveKey,
                  '저장',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteGrey,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  key: testKey,
                  '시험',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteGrey,
                  ),
                ),
              ),
            ],
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
                    onTap: () {},
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
                    KangiButton(
                      key: meanKey,
                      text: '의미',
                      onTap: () {
                        if (!isShownMean) {}
                      },
                    ),
                  const SizedBox(width: 16),
                  if (!isShownYomikata)
                    KangiButton(
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
                  KangiButton(
                    key: unKnownKey,
                    text: '몰라요',
                    onTap: () {
                      // nextWord(false);
                    },
                  ),
                  const SizedBox(width: 16),
                  KangiButton(
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
