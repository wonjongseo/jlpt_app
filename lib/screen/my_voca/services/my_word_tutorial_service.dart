import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MyVocaTutorialService {
  GlobalKey inputFormKey = GlobalKey(debugLabel: 'inputFormKey');
  GlobalKey inputFormCloseKey = GlobalKey(debugLabel: 'inputFormCloseKey');
  GlobalKey myVocaTouchKey = GlobalKey(debugLabel: 'myVocaTouchKey');
  GlobalKey flipKey = GlobalKey(debugLabel: 'flipKey');

  List<TargetFocus> targets = [];

  initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "inputFormKey",
          keyTarget: inputFormKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Padding(
                padding: EdgeInsets.only(top: 50),
                child: TutorialText(
                  title: '나만의 단어 저장',
                  subTitles: [
                    '[일본어], [읽는 법], [의미] 를 입력하여 나만의 단어를 저장 할 수 있습니다.'
                  ],
                ),
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "inputFormCloseKey",
          keyTarget: inputFormCloseKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                title: '입력 상자 닫기',
                subTitles: ['[입력 상자 닫기] 버튼을 클릭하여 입력 상자를 닫을 수 있습니다.'],
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
              child: const TutorialText(
                title: '나만의 단어',
                subTitles: [
                  '오른쪽으로 슬라이드 하여 [암기 / 미암기] 설정 할 수 있습니다.',
                  '왼쪽으로 슬라이드 하여 [삭제] 할 수 있습니다.',
                  '클릭하여 나만의 단어 정보를 볼 수 있습니다.'
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
