// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:japanese_voca/common/widget/dimentions.dart';
// import 'package:japanese_voca/config/colors.dart';
// import 'package:japanese_voca/features/setting/services/setting_controller.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class HomeTutorialService {
//   SettingController settingController = Get.find<SettingController>();
//   GlobalKey selectKey = GlobalKey(debugLabel: 'selectKey');
//   GlobalKey progressKey = GlobalKey(debugLabel: 'progressKey');
//   GlobalKey wrongWordKey = GlobalKey(debugLabel: 'wrongWordKey');
//   GlobalKey myVocaKey = GlobalKey(debugLabel: 'myVocaKey');
//   // GlobalKey welcomeKey = GlobalKey(debugLabel: 'welcomeKey');
//   GlobalKey bottomNavigationBarKey =
//       GlobalKey(debugLabel: 'bottomNavigationBarKey');
//   GlobalKey settingKey = GlobalKey(debugLabel: 'settingKey');

//   List<TargetFocus> targets = [];

//   Future settingFunctions() async {
//     //

//     bool isKeyBoardActive = await Get.dialog(
//       AlertDialog(
//         title: Text(
//           '주관식 문제를 활성화 하시겠습니까?',
//           style: TextStyle(
//             fontSize: Responsive.height16,
//           ),
//         ),
//         content: const Text(
//           '테스트 중에는 읽는 법을 직접 입력하는 기능이 있습니다. 해당 기능을 활성화 하시겠습니까?',
//         ),
//         actions: [
//           TextButton(
//               onPressed: () => Get.back(result: true),
//               child: Text(
//                 '네',
//                 style: TextStyle(
//                   color: AppColors.mainColor,
//                 ),
//               )),
//           TextButton(
//               onPressed: () => Get.back(result: false),
//               child: Text(
//                 '아니요',
//                 style: TextStyle(
//                   color: AppColors.mainColor,
//                 ),
//               )),
//         ],
//       ),
//     );

//     if (isKeyBoardActive) {
//       if (!settingController.isTestKeyBoard) {
//         settingController.flipTestKeyBoard();
//       }
//     } else {
//       if (settingController.isTestKeyBoard) {
//         settingController.flipTestKeyBoard();
//       }
//     }

//     Get.closeAllSnackbars();
//     Get.snackbar(
//       '초기 설정이 완료 되었습니다.',
//       '해당 설정들은 설정 페이지에서 재설정 할 수 있습니다.',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
//       duration: const Duration(seconds: 4),
//       animationDuration: const Duration(seconds: 2),
//     );
//   }

//   initTutorial() {
//     targets.addAll([
//       TargetFocus(
//         identify: "selectKey",
//         keyTarget: selectKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   '과목 선택',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(
//                           text: 'JLPT 단어, ',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(
//                           text: '문법, ',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(
//                           text: '한자',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 중 과목을 선택하여 집중적으로 학습 할 수 있습니다.')
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "progressKey",
//         keyTarget: progressKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   '진행률',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(text: '학습한 '),
//                       TextSpan(
//                           text: '진행률',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '을 확인 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "myVocaKey",
//         keyTarget: myVocaKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   '나만의 단어장',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 const Text.rich(
//                   TextSpan(
//                     text: '1. ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: '직접',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 일본어 단어를 '),
//                       TextSpan(
//                           text: '저장',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '하여 학습 할 수 있습니다.')
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text.rich(
//                   TextSpan(
//                     text: '2. ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: 'Excel 파일',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '을 이용해 나만의 단어를 관리 및 학습 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Responsive.height20),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "wrongWordKey",
//         keyTarget: wrongWordKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   '자주 틀리는 단어',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 const Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: 'JLPT 단어',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 혹은 '),
//                       TextSpan(
//                           text: 'JLPT 한자',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '를 학습하면서 '),
//                       TextSpan(
//                           text: '저장 버튼',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '을 통해 저장한 단어들을 확인 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Responsive.height60),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "bottomNavigationBarKey",
//         keyTarget: bottomNavigationBarKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'JLPT 레벨 선택',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(
//                           text: 'JLPT N1급 ~ ',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(
//                           text: 'N5급',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 을 선택 할 수 있습니다.')
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "settingKey",
//         keyTarget: settingKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   '설정 기능',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 const Text.rich(
//                   TextSpan(
//                     text: '1. ',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(text: '단어, 문법, 한자, 나만의 단어를 '),
//                       TextSpan(
//                           text: '초기화 (순서 섞기)',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 를 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Responsive.height10),
//                 const Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     text: '2. ',
//                     children: [
//                       TextSpan(
//                           text: '몰라요',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 버튼 클릭 시'),
//                       TextSpan(
//                           text: '[자동 저장] 기능',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 을 [ON / OFF] 할 수 있습니다.'),
//                       TextSpan(
//                           text: '\n[Plus 기능에 한함]',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Responsive.height10),
//                 const Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     text: '3. ',
//                     children: [
//                       TextSpan(
//                           text: '사운드 설정',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 및 '),
//                       TextSpan(
//                           text: '학습 시 자동 재생',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 을 [ON / OFF] 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Responsive.height10),
//                 const Text.rich(
//                   TextSpan(
//                     text: '4. ',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(text: ' 전반적인 앱 사용법을 볼 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ]);
//   }

//   void showTutorial(BuildContext context) {
//     TutorialCoachMark(
//       alignSkip: Alignment.topLeft,
//       onFinish: () => settingFunctions(),
//       onSkip: () {
//         settingFunctions();
//         return true;
//       },
//       textStyleSkip: const TextStyle(
//           color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold),
//       targets: targets, // List<TargetFocus>
//     ).show(context: context);
//   }
// }
