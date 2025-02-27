import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:japanese_voca/model/my_word.dart';

class SelectMyQuizDialog extends StatelessWidget {
  SelectMyQuizDialog({
    super.key,
    required this.myWords,
    required this.knownWordCount,
    required this.unKnownWordCount,
  });
  final List<MyWord> myWords;
  final int knownWordCount;
  final int unKnownWordCount;

  late FocusNode countOfTestFocusNode = FocusNode();
  late TextEditingController countEditContoller;
  bool isKnwonCheck = true;
  bool isUnKnwonCheck = true;
  List<MyWord> selectedWords = [];

  String errorMessage = '';
  bool isClickedFisrt = false; // 갯수 입력 버튼 누른 후
  // @override
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '선택된 암기된 단어는 $knownWordCount개,\n미암기된 단어는 ${unKnownWordCount}개입니다.',
              style: TextStyle(
                color: AppColors.scaffoldBackground,
                fontSize: Responsive.height14,
              ),
            ),
            SizedBox(height: Responsive.height10),
            Text(
              '테스트 종류를 선택 해주세요.',
              style: TextStyle(
                color: AppColors.scaffoldBackground,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.height14,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (errorMessage != '')
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.height14,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '암기 단어',
                  style: TextStyle(
                    color: AppColors.scaffoldBackground,
                    fontSize: Responsive.height16,
                  ),
                ),
                Checkbox(
                  activeColor:
                      isClickedFisrt ? Colors.grey : AppColors.mainColor,
                  value: isKnwonCheck,
                  onChanged: isClickedFisrt
                      ? null
                      : (value) {
                          setState(() {
                            isKnwonCheck = !isKnwonCheck;
                          });
                        },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '미암기 단어',
                  style: TextStyle(
                    color: AppColors.scaffoldBackground,
                    fontSize: Responsive.height16,
                  ),
                ),
                Checkbox(
                  value: isUnKnwonCheck,
                  activeColor:
                      isClickedFisrt ? Colors.grey : AppColors.mainColor,
                  onChanged: isClickedFisrt
                      ? null
                      : (value) {
                          setState(() {
                            isUnKnwonCheck = !isUnKnwonCheck;
                          });
                        },
                ),
              ],
            ),
            if (isClickedFisrt)
              SizedBox(
                height: Responsive.height50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: RichText(
                        text: TextSpan(
                          text: '문제 갯수 (',
                          children: [
                            TextSpan(
                              text: '${selectedWords.length}개',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            const TextSpan(text: ' 중에)')
                          ],
                          style: TextStyle(
                            color: AppColors.scaffoldBackground,
                            fontSize: Responsive.height16,
                            fontFamily: AppFonts.nanumGothic,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller: countEditContoller,
                        focusNode: countOfTestFocusNode,
                        style: const TextStyle(
                            color: AppColors.scaffoldBackground),
                        decoration: const InputDecoration(suffix: Text('개')),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: Responsive.height10),
            SizedBox(
              width: double.infinity,
              height: Responsive.height50,
              child: isClickedFisrt
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        '퀴즈 풀기',
                        style: TextStyle(
                          fontSize: Responsive.height14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        try {
                          int selectedQuizCount =
                              int.parse(countEditContoller.text);

                          if (selectedQuizCount > selectedWords.length) {
                            setState(() {
                              errorMessage =
                                  '${selectedWords.length} 보다 적은 수를 입력해주세요.';
                            });
                            return;
                          } else if (selectedQuizCount < 4) {
                            setState(() {
                              errorMessage = '단어 갯수가 4개 이상 이어야 합니다.';
                            });
                            return;
                          }

                          List<MyWord> quizWords = List.from(selectedWords);

                          quizWords.shuffle();

                          quizWords = quizWords.sublist(0, selectedQuizCount);

                          Get.back();
                          Get.toNamed(
                            JLPT_TEST_PATH,
                            arguments: {MY_VOCA_TEST: quizWords},
                          );
                        } catch (e) {
                          setState(() {
                            errorMessage = '숫자만 입력해주세요.';
                          });
                          return;
                        }
                      },
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (!isKnwonCheck && !isUnKnwonCheck) {
                          setState(() {
                            errorMessage =
                                '테스트 종류를 선택 해주세요.\n미암기 단어 혹은 암기 단어 중 하나 이상을 체크해주세요.';
                          });
                          return;
                        }

                        // 암기 + 미암기
                        if (isKnwonCheck && isUnKnwonCheck) {
                          selectedWords = myWords;
                          if (selectedWords.length < 4) {
                            setState(() {
                              errorMessage =
                                  '선택한 암기와 미암기 단어의 갯수가 ${selectedWords.length}개 입니다.\n퀴즈를 보기 위해서는 단어가 4개 이상 이어야 합니다.';
                            });
                            selectedWords = [];
                            return;
                          }
                          // 암기 단어만
                        } else if (isKnwonCheck && !isUnKnwonCheck) {
                          for (MyWord myWord in myWords) {
                            if (myWord.isKnown) {
                              selectedWords.add(myWord);
                            }
                          }
                          if (selectedWords.length < 4) {
                            setState(() {
                              errorMessage =
                                  '선택한 암기 단어의 갯수가 ${selectedWords.length}개 입니다.\n퀴즈를 보기 위해서는 단어가 4개 이상 이어야 합니다.';
                            });
                            selectedWords = [];
                            return;
                          }
                        } else if (!isKnwonCheck && isUnKnwonCheck) {
                          for (MyWord myWord in myWords) {
                            if (!myWord.isKnown) {
                              selectedWords.add(myWord);
                            }
                          }
                          if (selectedWords.length < 4) {
                            setState(() {
                              errorMessage =
                                  '선택한 암기 단어의 갯수가 ${selectedWords.length}개 입니다.\n퀴즈를 보기 위해서는 단어가 4개 이상 이어야 합니다.';
                            });
                            selectedWords = [];
                            return;
                          }
                        }

                        if (!isClickedFisrt) {
                          setState(() {
                            errorMessage = '';
                            isClickedFisrt = true;
                          });
                        }

                        countEditContoller = TextEditingController(
                          text: selectedWords.length.toString(),
                        );
                      },
                      child: Text(
                        '퀴즈 갯수 입력',
                        style: TextStyle(
                          fontSize: Responsive.height14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            )
          ],
        ),
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:japanese_voca/common/widget/dimentions.dart';
// import 'package:japanese_voca/config/colors.dart';
// import 'package:japanese_voca/config/theme.dart';
// import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
// import 'package:japanese_voca/model/my_word.dart';

// class SelectMyQuizDialog extends StatelessWidget {
//   SelectMyQuizDialog({
//     super.key,
//     required this.myWords,
//     required this.knownWordCount,
//     required this.unKnownWordCount,
//   });
//   final List<MyWord> myWords;
//   final int knownWordCount;
//   final int unKnownWordCount;

//   late FocusNode countOfTestFocusNode = FocusNode();
//   late TextEditingController countEditContoller;
//   bool isKnwonCheck = true;
//   bool isUnKnwonCheck = true;
//   List<MyWord> selectedWords = [];

//   String errorMessage = '';
//   bool isClickedFisrt = false; // 갯수 입력 버튼 누른 후
//   // @override
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, setState) {
//       return AlertDialog(
//         title: Text(
//           '테스트 종류를 선택 해주세요.',
//           style: TextStyle(
//             color: AppColors.scaffoldBackground,
//             fontWeight: FontWeight.bold,
//             fontSize: Responsive.width15,
//           ),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (errorMessage != '')
//               Text(
//                 errorMessage,
//                 style: TextStyle(
//                   color: Colors.redAccent,
//                   fontWeight: FontWeight.bold,
//                   fontSize: Responsive.height14,
//                 ),
//               ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '미암기 단어',
//                   style: TextStyle(
//                     color: AppColors.scaffoldBackground,
//                     fontSize: Responsive.height16,
//                   ),
//                 ),
//                 Checkbox(
//                   value: isUnKnwonCheck,
//                   activeColor:
//                       isClickedFisrt ? Colors.grey : AppColors.mainColor,
//                   onChanged: isClickedFisrt
//                       ? null
//                       : (value) {
//                           setState(() {
//                             isUnKnwonCheck = !isUnKnwonCheck;
//                           });
//                         },
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '암기 단어',
//                   style: TextStyle(
//                     color: AppColors.scaffoldBackground,
//                     fontSize: Responsive.height16,
//                   ),
//                 ),
//                 Checkbox(
//                   activeColor:
//                       isClickedFisrt ? Colors.grey : AppColors.mainColor,
//                   value: isKnwonCheck,
//                   onChanged: isClickedFisrt
//                       ? null
//                       : (value) {
//                           setState(() {
//                             isKnwonCheck = !isKnwonCheck;
//                           });
//                         },
//                 ),
//               ],
//             ),
//             if (isClickedFisrt)
//               SizedBox(
//                 height: Responsive.height50,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: RichText(
//                         text: TextSpan(
//                           text: '문제 갯수 (',
//                           children: [
//                             TextSpan(
//                               text: '${selectedWords.length}개',
//                               style: const TextStyle(
//                                 color: Colors.red,
//                               ),
//                             ),
//                             const TextSpan(text: ' 중에)')
//                           ],
//                           style: TextStyle(
//                             color: AppColors.scaffoldBackground,
//                             fontSize: Responsive.height16,
//                             fontFamily: AppFonts.nanumGothic,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: TextFormField(
//                         autofocus: true,
//                         keyboardType: TextInputType.number,
//                         controller: countEditContoller,
//                         focusNode: countOfTestFocusNode,
//                         style: const TextStyle(
//                             color: AppColors.scaffoldBackground),
//                         decoration: const InputDecoration(suffix: Text('개')),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             SizedBox(height: Responsive.height10),
//             SizedBox(
//               width: double.infinity,
//               height: Responsive.height50,
//               child: isClickedFisrt
//                   ? ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.mainColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         '퀴즈 풀기',
//                         style: TextStyle(
//                           fontSize: Responsive.height14,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       onPressed: () {
//                         try {
//                           int selectedQuizCount =
//                               int.parse(countEditContoller.text);

//                           if (selectedQuizCount > selectedWords.length) {
//                             setState(() {
//                               errorMessage =
//                                   '${selectedWords.length} 보다 적은 수를 입력해주세요.';
//                             });
//                             return;
//                           } else if (selectedQuizCount < 4) {
//                             setState(() {
//                               errorMessage = '단어 갯수가 4개 이상 이어야 합니다.';
//                             });
//                             return;
//                           }

//                           List<MyWord> quizWords = List.from(selectedWords);

//                           quizWords.shuffle();

//                           quizWords = quizWords.sublist(0, selectedQuizCount);

//                           Get.back();
//                           Get.toNamed(
//                             JLPT_TEST_PATH,
//                             arguments: {MY_VOCA_TEST: quizWords},
//                           );
//                         } catch (e) {
//                           setState(() {
//                             errorMessage = '숫자만 입력해주세요.';
//                           });
//                           return;
//                         }
//                       },
//                     )
//                   : ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.mainColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () {
//                         print('knownWordCount : ${knownWordCount}');
//                         print('unKnownWordCount : ${unKnownWordCount}');
//                         // 암기 + 미암기

//                         if (isKnwonCheck && isUnKnwonCheck) {
//                           selectedWords = myWords;

//                         } else if (isKnwonCheck && !isUnKnwonCheck) {
//                           for (MyWord myWord in myWords) {
//                             if (myWord.isKnown) {
//                               selectedWords.add(myWord);
//                             }
//                           }
//                         } else if (!isKnwonCheck && isUnKnwonCheck) {
//                           for (MyWord myWord in myWords) {
//                             if (!myWord.isKnown) {
//                               selectedWords.add(myWord);
//                             }
//                           }
//                         } else {
//                           setState(() {
//                             errorMessage = '테스트 종류를 선택 해주세요.';
//                           });
//                           return;
//                         }

//                         if (selectedWords.length < 4) {
//                           setState(() {
//                             errorMessage = '단어 갯수가 4개 이상 이어야 합니다.';
//                           });
//                           return;
//                         }
//                         if (!isClickedFisrt) {
//                           setState(() {
//                             isClickedFisrt = true;
//                           });
//                         }

//                         countEditContoller = TextEditingController(
//                           text: selectedWords.length.toString(),
//                         );
//                       },
//                       child: Text(
//                         '퀴즈 갯수 입력',
//                         style: TextStyle(
//                           fontSize: Responsive.height14,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
