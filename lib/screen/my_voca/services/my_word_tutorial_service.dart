import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MyVocaTutorialService {
  GlobalKey inputIconKey = GlobalKey(debugLabel: 'inputIconKey');
  GlobalKey myVocaTouchKey = GlobalKey(debugLabel: 'myVocaTouchKey');
  GlobalKey flipKey = GlobalKey(debugLabel: 'flipKey');

  List<TargetFocus> targets = [];

  initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "inputIconKey",
          keyTarget: inputIconKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나만의 단어 저장',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                      children: [
                        TextSpan(
                            text: '일본어', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ', '),
                        TextSpan(
                            text: '읽는 법', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ', '),
                        TextSpan(
                            text: '의미', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ', '),
                        TextSpan(text: '를 입력하여 나만의 단어를 저장 할 수 있습니다.')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "myVocaTouchKey",
          keyTarget: myVocaTouchKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '나만의 단어',
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
                        TextSpan(text: '오른쪽으로 슬라이드 하여 '),
                        TextSpan(
                            text: '암기', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ' 또는 '),
                        TextSpan(
                            text: '미암기', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ' 으로 설정 할 수 있습니다.')
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14.0),
                      children: [
                        TextSpan(text: '왼쪽으로 슬라이드 하여 '),
                        TextSpan(
                            text: '삭제', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ' 할 수 있습니다.')
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "",
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                      children: [
                        TextSpan(
                            text: '클릭', style: TextStyle(color: Colors.red)),
                        TextSpan(text: '하여 나만의 단어 정보를 볼 수 있습니다.')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "flipKey",
          keyTarget: flipKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                title: '플립 기능',
                subTitles: [
                  '암기된 단어만 보기',
                  '미암기된 단어만 보기',
                  '모든 단어를 보기',
                  '일본어와 읽는법을 뒤집어서 보기',
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showTutorial(BuildContext context, Function() onFlish) {
    TutorialCoachMark(
      onFinish: onFlish,
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets, // List<TargetFocus>
    ).show(context: context);
  }
}
