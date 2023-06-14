import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeTutorialService {
  GlobalKey selectKey = GlobalKey(debugLabel: 'selectKey');
  GlobalKey progressKey = GlobalKey(debugLabel: 'progressKey');
  GlobalKey wrongWordKey = GlobalKey(debugLabel: 'wrongWordKey');
  GlobalKey myVocaKey = GlobalKey(debugLabel: 'myVocaKey');
  GlobalKey welcomeKey = GlobalKey(debugLabel: 'welcomeKey');
  GlobalKey bottomNavigationBarKey =
      GlobalKey(debugLabel: 'bottomNavigationBarKey');
  GlobalKey settingKey = GlobalKey(debugLabel: 'settingKey');

  List<TargetFocus> targets = [];

  initTutorial() {
    targets.addAll([
      TargetFocus(
        identify: "selectKey",
        keyTarget: selectKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '과목 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                    children: [
                      TextSpan(
                          text: 'JLPT 단어', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ', '),
                      TextSpan(text: '문법', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ', '),
                      TextSpan(text: '한자', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 중 과목을 선택하여 집중적으로 학습 할 수 있습니다.')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "progressKey",
        keyTarget: progressKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '진행률',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                    children: [
                      TextSpan(text: '학습한 '),
                      TextSpan(
                          text: '진행률', style: TextStyle(color: Colors.red)),
                      TextSpan(text: '을 확인 할 수 있습니다.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "wrongWordKey",
        keyTarget: wrongWordKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '자주 틀리는 문제',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                    children: [
                      TextSpan(
                          text: 'JLPT 단어', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 혹은 '),
                      TextSpan(
                          text: 'JLPT 한자', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 를 학습하면서 '),
                      TextSpan(
                          text: '저장 버튼', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 을 누른 단어들을 확인 할 수 있습니다.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "myVocaKey",
        keyTarget: myVocaKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나만의 단어장',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Text.rich(
                  TextSpan(
                    text: '1. ',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                    children: [
                      TextSpan(text: '직접', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 일본어 단어를 '),
                      TextSpan(text: '저장', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 하여 학습 할 수 있습니다.')
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '2. ',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                    children: [
                      TextSpan(
                          text: 'Excel 파일',
                          style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 을 이용해 나만의 단어를 관리 및 학습 할 수 있습니다.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "bottomNavigationBarKey",
        keyTarget: bottomNavigationBarKey,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JLPT 레벨 선택',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                    children: [
                      TextSpan(
                          text: 'JLPT N1', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' ~ '),
                      TextSpan(text: 'N5', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 를 선택 할 수 있습니다.')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "settingKey",
        keyTarget: settingKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: const TutorialText(
              title: '설정 기능',
              subTitles: [
                '단어, 문법, 한자, 나만의 단어를 초기화 (순서 섞기) 를 할 수 있습니다.',
                '[몰라요] 버튼 클릭 시 [자동 저장] 기능 [ON / OFF] 을 할 수 있습니다.',
                '[JLPT 단어 테스트] 에서 키보드 기능 [ON / OFF] 을 할 수 있습니다.'
              ],
            ),
          )
        ],
      ),
    ]);
  }

  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets, // List<TargetFocus>
    ).show(context: context);
  }
}
