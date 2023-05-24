// import 'package:flutter/material.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class WordStudyTutorialService {
//   static GlobalKey grammarKey = GlobalKey(debugLabel: 'grammarKey');
//   static GlobalKey myVocaKey = GlobalKey(debugLabel: 'myVocaKey');
//   static GlobalKey jlptN1Key = GlobalKey(debugLabel: 'jlptN1Key');

//   static GlobalKey welcomeKey = GlobalKey(debugLabel: 'welcomeKey');
//   static GlobalKey settingKey = GlobalKey(debugLabel: 'settingKey');

//   static List<TargetFocus> targets = [];

//   static initTutorial() {
//     targets.addAll([
//       TargetFocus(
//         identify: "Jlpt Button",
//         keyTarget: jlptN1Key,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const Text(
//               "JLPT N1 ~ N5 까지 단어 학습 가능.",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 20.0),
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "Grammar Tap",
//         keyTarget: grammarKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const Text(
//               "JLPT N1 ~ N3 까지 문법 학습 가능.",
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 20.0),
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "MyVoca Tap",
//         keyTarget: myVocaKey,
//         contents: [
//           TargetContent(
//               align: ContentAlign.top,
//               child: const Column(
//                 children: [
//                   Text(
//                     "직접 단어를 저장 가능",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20.0),
//                   ),
//                   Text(
//                     "Excel 파일의 단어를 종각 APP에 저장 가능",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20.0),
//                   ),
//                 ],
//               )),
//         ],
//       ),
//       TargetFocus(
//         identify: "Target 4",
//         keyTarget: settingKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             child: const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "설정 페이지",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 20.0),
//               ),
//             ),
//           )
//         ],
//       ),
//     ]);
//   }

//   static void showTutorial(BuildContext context) {
//     TutorialCoachMark(
//       targets: targets, // List<TargetFocus>
//     ).show(context: context);
//   }
// }
