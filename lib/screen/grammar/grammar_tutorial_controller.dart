import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class GrammarTutorialController extends GetxController {
  List<TargetFocus> targets = [];
  GlobalKey grammarKey = GlobalKey();
  GlobalKey exampleKey = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();
  GlobalKey key5 = GlobalKey();
  GlobalKey key6 = GlobalKey();

  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'grammar') {}

        if (target.identify == 'exampleKey') {
          print('exampleKeyexampleKey');
        }
        //
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("'onClickTargetWithTapPosition");
      },
      onClickOverlay: (target) {
        print('onClickOverlay');
      },
      onSkip: () {
        // Get.toNamed();
      },
      onFinish: () {
        // Get.toNamed(WORD_STUDY_PATH);
      },
    ).show(context: context);
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "grammar",
          keyTarget: grammarKey,
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
          identify: "exampleKey",
          keyTarget: exampleKey,
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
          keyTarget: key3,
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
          keyTarget: key4,
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
          keyTarget: key5,
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
          keyTarget: key6,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Text.rich(
                TextSpan(
                  text: "[TEST] 버튼을 클릭하면 ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0),
                  children: [
                    TextSpan(text: '의미', style: TextStyle(color: Colors.red)),
                    TextSpan(text: ' 또는 '),
                    TextSpan(text: '읽는법 ', style: TextStyle(color: Colors.red)),
                    TextSpan(text: '으로 테스트를 진행할 수 있습니다 ')
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
