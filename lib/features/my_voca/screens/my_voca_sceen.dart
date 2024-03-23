import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:japanese_voca/features/my_voca/widgets/my_word_input_field.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/my_voca/widgets/upload_excel_infomation.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/excel.dart';

const MY_VOCA_PATH = '/my_voca';

// ignore: must_be_immutable
class MyVocaPage extends StatelessWidget {
  UserController userController = Get.find<UserController>();
  late AdController? adController;
  late MyVocaController myVocaController;

  MyVocaPage({super.key}) {
    bool isMyVocaPage = Get.arguments[MY_VOCA_TYPE] == MyVocaEnum.MY_WORD;

    myVocaController = Get.put(
      MyVocaController(isMyVocaPage: isMyVocaPage),
    );
    adController = Get.find<AdController>();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double responsiveWordBoxHeight = size.width > 700 ? 130 : 50;
    double responsiveTextFontSize = size.width > 700 ? 30 : 18;

    final kFirstDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month - 3, myVocaController.kToday.day);
    final kLastDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month + 3, myVocaController.kToday.day);

    return GetBuilder<MyVocaController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: const GlobalBannerAdmob(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            controller.isMyVocaPage ? 'My Voca' : 'Wrong Voca',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          actions: [
            if (controller.isMyVocaPage)
              TextButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      content: MyWordInputField(
                        saveWord: controller.manualSaveMyWord,
                        wordFocusNode: controller.wordFocusNode,
                        wordController: controller.wordController,
                        yomikataFocusNode: controller.yomikataFocusNode,
                        yomikataController: controller.yomikataController,
                        meanFocusNode: controller.meanFocusNode,
                        meanController: controller.meanController,
                      ),
                    ),
                  );
                },
                child: const Text(
                  '단어 추가',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Material(
                  textStyle:
                      const TextStyle(color: AppColors.scaffoldBackground),
                  child: TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: controller.focusedDay,
                    calendarFormat: controller.calendarFormat,
                    eventLoader: controller.getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    selectedDayPredicate: (day) {
                      return controller.selectedDays.contains(day);
                    },
                    onDaySelected: controller.onDaySelected,
                    onFormatChanged: controller.onFormatChanged,
                    onPageChanged: (focusedDay) {
                      controller.focusedDay = focusedDay;
                    },
                  ),
                ),
              ),
              Divider(height: Responsive.height40),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: OutlinedButton(
                              child: const Text(
                                '필터',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () =>
                                  controller.openDialogForchangeFunc(),
                            ),
                          ),
                          if (controller.isMyVocaPage)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: OutlinedButton(
                                onPressed: clickExcelButton,
                                child: const Text(
                                  '엑셀',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          if (controller.myWords.length >= 4)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: OutlinedButton(
                                child: const Text(
                                  '퀴즈',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {
                                  bool isKnwonCheck = true;
                                  bool isUnKnwonCheck = true;
                                  String errorMessage = '';
                                  Get.dialog(
                                    ValueListenableBuilder<List<MyWord>>(
                                        valueListenable:
                                            controller.selectedEvents,
                                        builder: (context, value, _) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: const Text(
                                                    '테스트 종류를 선택 해주세요.',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .scaffoldBackground,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    )),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      errorMessage,
                                                      style: const TextStyle(
                                                        color: Colors.redAccent,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          '미암기 단어',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .scaffoldBackground,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Checkbox(
                                                            value:
                                                                isUnKnwonCheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isUnKnwonCheck =
                                                                    !isUnKnwonCheck;
                                                              });
                                                            }),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          '암기한 단어',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .scaffoldBackground,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Checkbox(
                                                            value: isKnwonCheck,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                isKnwonCheck =
                                                                    !isKnwonCheck;
                                                              });
                                                            }),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            List<MyWord>
                                                                tempMyWord = [];

                                                            if (isKnwonCheck &&
                                                                isUnKnwonCheck) {
                                                              tempMyWord =
                                                                  value;
                                                            } else if (isKnwonCheck &&
                                                                !isUnKnwonCheck) {
                                                              for (MyWord myWord
                                                                  in value) {
                                                                if (myWord
                                                                    .isKnown) {
                                                                  tempMyWord.add(
                                                                      myWord);
                                                                }
                                                              }
                                                            } else if (!isKnwonCheck &&
                                                                isUnKnwonCheck) {
                                                              for (MyWord myWord
                                                                  in value) {
                                                                if (!myWord
                                                                    .isKnown) {
                                                                  tempMyWord.add(
                                                                      myWord);
                                                                }
                                                              }
                                                            } else {
                                                              setState(() {
                                                                errorMessage =
                                                                    '테스트 종류를 선택 해주세요.';
                                                              });
                                                              return;
                                                            }

                                                            if (tempMyWord
                                                                    .length <
                                                                4) {
                                                              setState(() {
                                                                errorMessage =
                                                                    '테스트 단어 개수가 4개 이상 이어야 합니다.';
                                                              });
                                                              return;
                                                            }
                                                            Get.toNamed(
                                                              JLPT_TEST_PATH,
                                                              arguments: {
                                                                MY_VOCA_TEST:
                                                                    tempMyWord
                                                              },
                                                            );
                                                          },
                                                          child: const Text(
                                                              '테스트 하기')),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  );
                                },
                              ),
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ValueListenableBuilder<List<MyWord>>(
                        valueListenable: controller.selectedEvents,
                        builder: (context, value, _) {
                          return Column(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: Responsive.width10,
                                  left: Responsive.width10,
                                  bottom: Responsive.height10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      // textAlign: TextAlign.left,
                                      TextSpan(
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: Responsive.width15,
                                        ),
                                        text: '선택된 단어 개수: ',
                                        children: [
                                          TextSpan(
                                            text: ' ${value.length}개',
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ...List.generate(
                                      value.length,
                                      (index) {
                                        if (controller.isOnlyKnown) {
                                          if (value[index].isKnown == false) {
                                            return const SizedBox();
                                          }
                                        } else if (controller.isOnlyUnKnown) {
                                          if (value[index].isKnown == true) {
                                            return const SizedBox();
                                          }
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                          child: Slidable(
                                            startActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    value[index].isKnown == true
                                                        ? controller.updateWord(
                                                            value[index].word,
                                                            false)
                                                        : controller.updateWord(
                                                            value[index].word,
                                                            true);
                                                  },
                                                  backgroundColor:
                                                      Colors.blueAccent,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.check,
                                                  label: value[index].isKnown ==
                                                          true
                                                      ? '미암기'
                                                      : '암기',
                                                ),
                                              ],
                                            ),
                                            endActionPane: ActionPane(
                                              motion: const ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  onPressed: (context) {
                                                    controller.myWords
                                                        .remove(value[index]);
                                                    controller.deleteWord(
                                                      value[index],
                                                    );
                                                  },
                                                  backgroundColor:
                                                      const Color(0xFFFE4A49),
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete,
                                                  label: '삭제',
                                                ),
                                              ],
                                            ),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    value[index].isKnown
                                                        ? AppColors.correctColor
                                                        : AppColors.lightGrey,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                padding: const EdgeInsets.only(
                                                    left: 4),
                                              ),
                                              onPressed: () {
                                                Get.to(
                                                  () => Scaffold(
                                                    appBar: AppBar(),
                                                    body: WordCard(
                                                        word: Word.myWordToWord(
                                                            value[index])),
                                                  ),
                                                );
                                                // controller
                                                //     .openDialogForclickMyWord(
                                                //         context, value[index]);
                                              },
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  SizedBox(
                                                    height:
                                                        responsiveWordBoxHeight,
                                                    child: Center(
                                                        child: Text(
                                                      controller.isWordFlip
                                                          ? value[index].mean
                                                          : value[index].word,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .scaffoldBackground,
                                                          fontSize:
                                                              responsiveTextFontSize,
                                                          fontFamily: AppFonts
                                                              .japaneseFont),
                                                    )),
                                                  ),
                                                  if (value[index].createdAt !=
                                                      null)
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                          '${value[index].createdAtString()} 에 저장됨'),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void clickExcelButton() async {
    bool? result = await Get.dialog<bool>(
      AlertDialog(
        title: const Text(
          'EXCEL 데이터 형식',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ),
        content: const UploadExcelInfomation(),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              '파일 첨부하기',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );

    if (result != null) {
      bool result2 = await askToWatchMovieAndGetHeart(
        title: const Text('엑셀 단어 등록하기'),
        content: const Text(
          '광고를 시청하고 엑셀의 단어를 JLPT종각에 저장하시겠습니까?',
          style: TextStyle(color: AppColors.scaffoldBackground),
        ),
      );

      if (result2) {
        int savedWordNumber = await postExcelData();
        if (savedWordNumber != 0) {
          Get.offNamed(
            MY_VOCA_PATH,
            arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
            preventDuplicates: false,
          );
          adController!.showRewardedInterstitialAd();
        }
      }
    }
  }
}
