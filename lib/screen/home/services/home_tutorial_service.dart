import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeTutorialService {
  GlobalKey grammarKey = GlobalKey(debugLabel: 'grammarKey');
  GlobalKey myVocaKey = GlobalKey(debugLabel: 'myVocaKey');
  GlobalKey jlptN1Key = GlobalKey(debugLabel: 'jlptN1Key');

  GlobalKey welcomeKey = GlobalKey(debugLabel: 'welcomeKey');
  GlobalKey settingKey = GlobalKey(debugLabel: 'settingKey');

  List<TargetFocus> targets = [];

  initTutorial() {
    targets.addAll([
      TargetFocus(
        identify: "jlptN1Key",
        keyTarget: jlptN1Key,
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
                    text: "",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0),
                    children: [
                      TextSpan(text: 'N1', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' ~ '),
                      TextSpan(text: 'N5', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 단어를 볼 수 있습니다.')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "grammarKey",
        keyTarget: grammarKey,
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
                    text: "",
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0),
                    children: [
                      TextSpan(text: 'N1', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' ~ '),
                      TextSpan(text: 'N3', style: TextStyle(color: Colors.red)),
                      TextSpan(text: ' 문법을 볼 수 있습니다.')
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
              align: ContentAlign.top,
              child: const TutorialText(
                title: '나만의 단어',
                subTitles: [
                  '직접 단어를 저장하여 학습 할 수 있습니다.',
                  '웹 사이트에서 Excel 파일을 업로드 하여 학습 할 수 있습니다.'
                ],
              )),
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
                '[몰라요] 버튼 클릭 시 [자동 저장] 기능 [ON / OFF]',
                '[의미, 읽는 법] 의 [글자 개수 표시] 기능 [ON / OFF]'
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
