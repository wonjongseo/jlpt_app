import 'package:flutter/material.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialController {
  // Home
  static List<TargetFocus> homeScreenTargets = [];
  static GlobalKey grammarKey = GlobalKey(debugLabel: 'Grammar');
  static GlobalKey jlptN1Key = GlobalKey(debugLabel: 'JlptN1');
  static GlobalKey welcomeKey = GlobalKey(debugLabel: 'Welcome');
  static GlobalKey settingKey = GlobalKey(debugLabel: 'Setting');

  // JlptScreen
  static List<TargetFocus> jlptScreenScreenTargets = [];
  static GlobalKey chapterKey = GlobalKey(debugLabel: 'Grammar');

  static void prepareHomeTutorial() {
    homeScreenTargets.add(
        TargetFocus(identify: "Target 1", keyTarget: welcomeKey, contents: [
      TargetContent(
          align: ContentAlign.bottom,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Titulo lorem ipsum",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ))
    ]));

    homeScreenTargets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: jlptN1Key,
        contents: [
          TargetContent(
              align: ContentAlign.left,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
          TargetContent(
              align: ContentAlign.right,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
      ),
    );

    homeScreenTargets.add(
      TargetFocus(
        identify: "Target 3",
        keyTarget: grammarKey,
        contents: [
          TargetContent(
              align: ContentAlign.right,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Title lorem ipsum",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
      ),
    );

    homeScreenTargets.add(
      TargetFocus(
        identify: "Target 4",
        keyTarget: settingKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            // child: const Column(
            //   mainAxisSize: MainAxisSize.min,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       "Title lorem ipsum",
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //           fontSize: 20.0),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 10.0),
            //       child: Text(
            //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     )
            //   ],
            // ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "설정 페이지",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  static void showTutorial(String sceen, BuildContext context) {
    List<TargetFocus> targets = [];

    switch (sceen) {
      case 'home':
        targets = homeScreenTargets;
        break;

      case JLPT_PATH:
        targets = jlptScreenScreenTargets;
        break;
    }

    TutorialCoachMark(
      targets: targets, // List<TargetFocus>
      // alignSkip: Alignment.bottomRight,
      // textSkip: "SKIP",
      // paddingFocus: 10,
      // opacityShadow: 0.8,
      onClickTarget: (target) {
        // print(target);
        print('onClickTarget');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print('onClickTargetWithTapPosition');
        // print("target: $target");
        // print(
        // "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay');

        // print(target);
      },
      onSkip: () {
        print('onSkip');

        // print("skip");
      },
      onFinish: () {
        print('onFinish');

        // print("finish");
      },
    ).show(context: context);
  }

  static void prepareJlptSceenTutorial() {
    jlptScreenScreenTargets.add(
        TargetFocus(identify: "Target 1", keyTarget: chapterKey, contents: [
      TargetContent(
          align: ContentAlign.bottom,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Titulo lorem ipsum",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ))
    ]));
  }
}
