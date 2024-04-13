// import 'package:flutter/material.dart';
// import 'package:japanese_voca/common/widget/dimentions.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class HomeScreenTutorialController {
//   GlobalKey? searchBtnKey = GlobalKey(debugLabel: 'searchBtnKey');
//   GlobalKey? bookIndicatorKey = GlobalKey(debugLabel: 'bookIndicatorKey');
//   GlobalKey? bookCardKey = GlobalKey(debugLabel: 'bookCardKey');

//   List<TargetFocus> targets = [];

//   initTutorial() {
//     targets.addAll(
//       [
//         TargetFocus(
//           identify: "searchBtnKey",
//           keyTarget: searchBtnKey,
//           contents: [
//             TargetContent(
//               align: ContentAlign.bottom,
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '일본어 단어 검색',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0,
//                     ),
//                   ),
//                   Text(
//                     '종각앱에 저장되어 있는 일본어를 검색할 수 있습니다.',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white,
//                       fontSize: 18.0,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         TargetFocus(
//           identify: "bookIndicatorKey",
//           keyTarget: bookIndicatorKey,
//           contents: [
//             TargetContent(
//               align: ContentAlign.top,
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '달력 열고 접기',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 22.0),
//                   ),
//                   Text.rich(
//                     TextSpan(
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.bold),
//                       children: [
//                         TextSpan(
//                             text: '나만의 단어',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: '을 클릭하여 '),
//                         TextSpan(
//                             text: '달력',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: '을 표시 / 미표시 할 수 있습니다.'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         TargetFocus(
//           identify: "bookCardKey",
//           keyTarget: bookCardKey,
//           contents: [
//             TargetContent(
//               align: ContentAlign.bottom,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     '나만의 단어',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 22.0),
//                   ),
//                   const Text.rich(
//                     TextSpan(
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.bold),
//                       text: '1. ',
//                       children: [
//                         TextSpan(
//                             text: '오른쪽으로 슬라이드',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: ' 하여 '),
//                         TextSpan(
//                             text: '암기',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: ' 또는 '),
//                         TextSpan(
//                             text: '미암기',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: ' 으로 설정 할 수 있습니다.')
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: Responsive.height10),
//                   const Text.rich(
//                     TextSpan(
//                       text: '2. ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.bold),
//                       children: [
//                         TextSpan(
//                             text: '왼쪽으로 슬라이드',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: ' 하여 '),
//                         TextSpan(
//                             text: '삭제',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: ' 할 수 있습니다.')
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: Responsive.height10),
//                   const Text.rich(
//                     TextSpan(
//                       text: '3. ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15.0,
//                           fontWeight: FontWeight.bold),
//                       children: [
//                         TextSpan(
//                             text: '클릭',
//                             style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17,
//                             )),
//                         TextSpan(text: '하여 나만의 단어 정보를 볼 수 있습니다.')
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void showTutorial(BuildContext context, Function() onFlish) {
//     initTutorial();
//     TutorialCoachMark(
//       onFinish: () {
//         searchBtnKey = null;
//         bookIndicatorKey = null;
//         bookCardKey = null;

//         onFlish();
//       },
//       onSkip: () {
//         searchBtnKey = null;
//         bookIndicatorKey = null;
//         bookCardKey = null;

//         onFlish();
//         return true;
//       },
//       alignSkip: Alignment.topLeft,
//       textStyleSkip: const TextStyle(
//           color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
//       targets: targets,
//     ).show(context: context);
//   }
// }
