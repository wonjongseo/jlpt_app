import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_study_screen.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:japanese_voca/features/my_voca/widgets/my_word_input_field.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';

const MY_VOCA_PATH = '/my_voca';

// ignore: must_be_immutable
class MyVocaPage extends StatefulWidget {
  late AdController? adController;
  late bool isManualSavedWord;

  MyVocaPage({super.key}) {
    isManualSavedWord =
        Get.arguments[MY_VOCA_TYPE] == MyVocaEnum.MANUAL_SAVED_WORD;

    adController = Get.find<AdController>();
  }

  @override
  State<MyVocaPage> createState() => _MyVocaPageState();
}

class _MyVocaPageState extends State<MyVocaPage> {
  UserController userController = Get.find<UserController>();

  List<String> filters1 = [
    '모든 단어',
    '암기 단어',
    '미암기 단어',
  ];
  List<String> filters2 = [
    '뜻',
    '의미',
  ];
  String selectedFilter1 = '모든 단어';
  String selectedFilter2 = '뜻';
  late MyVocaController myVocaController;
  @override
  void initState() {
    super.initState();
    myVocaController = Get.put(
        MyVocaController(isManualSavedWordPage: widget.isManualSavedWord));
  }

  @override
  Widget build(BuildContext context) {
    final kFirstDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month - 3, myVocaController.kToday.day);
    final kLastDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month + 3, myVocaController.kToday.day);

    return GetBuilder<MyVocaController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: const GlobalBannerAdmob(),
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: Text(
            controller.isManualSavedWordPage ? '나만의 단어장 2' : '나만의 단어장 1',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.height10 * 1.8,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Responsive.width10 * 0.8),
                child: Material(
                  textStyle: TextStyle(
                    color: AppColors.scaffoldBackground,
                    fontSize: Responsive.height14,
                  ),
                  child: TableCalendar(
                    rowHeight: Responsive.height10 * 5.2,
                    daysOfWeekHeight: Responsive.height10 * 2.2,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width10 * 0.8),
                      child: Stack(
                        children: [
                          if (controller.isManualSavedWordPage)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: OutlinedButton(
                                child: Text(
                                  '단어 추가',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Responsive.height14,
                                  ),
                                ),
                                onPressed: () {
                                  Get.dialog(
                                    const AlertDialog(
                                      content: MyWordInputField(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (controller.myWords.length >= 4)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: OutlinedButton(
                                child: Text(
                                  '퀴즈',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: Responsive.height14,
                                  ),
                                ),
                                onPressed: () {
                                  Get.dialog(const PPPPPP());
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
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Responsive.width10,
                                    left: Responsive.width10,
                                    bottom: Responsive.height10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: Responsive.width15,
                                        ),
                                        text: '선택된 단어: ',
                                        children: [
                                          TextSpan(
                                            text: ' ${value.length}개',
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '필터: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: Responsive.width15,
                                          ),
                                        ),
                                        DropdownButton(
                                          value: selectedFilter1,
                                          // underline: const SizedBox(),
                                          items: List.generate(
                                            filters1.length,
                                            (index) => DropdownMenuItem(
                                              value: filters1[index],
                                              child: Text(
                                                filters1[index],
                                                style: selectedFilter1 ==
                                                        filters1[index]
                                                    ? TextStyle(
                                                        color: Colors
                                                            .cyan.shade700,
                                                        fontSize:
                                                            Responsive.height14,
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          onChanged: (v) {
                                            selectedFilter1 = v!;

                                            if (selectedFilter1 == '모든 단어') {
                                              //암기단어
                                              controller.isAll();
                                            } else if (selectedFilter1 ==
                                                '암기 단어') {
                                              controller.isKnow();
                                            } else if (selectedFilter1 ==
                                                '미암기 단어') {
                                              controller.isDontKnow();
                                            }

                                            setState(() {});
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        DropdownButton(
                                          value: selectedFilter2,
                                          // underline: const SizedBox(),
                                          items: List.generate(
                                              filters2.length,
                                              (index) => DropdownMenuItem(
                                                    value: filters2[index],
                                                    child: Text(
                                                      filters2[index],
                                                      style: selectedFilter2 ==
                                                              filters2[index]
                                                          ? TextStyle(
                                                              fontSize:
                                                                  Responsive
                                                                      .height14,
                                                              color: Colors.cyan
                                                                  .shade700,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)
                                                          : null,
                                                    ),
                                                  )),
                                          onChanged: (v) {
                                            if (v == '의미') {
                                              controller.isWordFlip = true;
                                            } else {
                                              controller.isWordFlip = false;
                                            }
                                            selectedFilter2 = v!;

                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        controller.selectedWord.length,
                                        (index) {
                                          if (controller.isOnlyKnown) {
                                            if (controller.selectedWord[index]
                                                    .isKnown ==
                                                false) {
                                              return const SizedBox();
                                            }
                                          } else if (controller.isOnlyUnKnown) {
                                            if (controller.selectedWord[index]
                                                    .isKnown ==
                                                true) {
                                              return const SizedBox();
                                            }
                                          }
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Responsive.width10,
                                              vertical:
                                                  Responsive.height10 * 0.7,
                                            ),
                                            child: Slidable(
                                              startActionPane: ActionPane(
                                                motion: const ScrollMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (context) {
                                                      controller
                                                                  .selectedWord[
                                                                      index]
                                                                  .isKnown ==
                                                              true
                                                          ? controller.updateWord(
                                                              controller
                                                                  .selectedWord[
                                                                      index]
                                                                  .word,
                                                              false)
                                                          : controller.updateWord(
                                                              controller
                                                                  .selectedWord[
                                                                      index]
                                                                  .word,
                                                              true);
                                                    },
                                                    backgroundColor:
                                                        Colors.blueAccent,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.check,
                                                    label: controller
                                                                .selectedWord[
                                                                    index]
                                                                .isKnown ==
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
                                                      controller.myWords.remove(
                                                          controller
                                                                  .selectedWord[
                                                              index]);
                                                      controller.deleteWord(
                                                        controller.selectedWord[
                                                            index],
                                                        isYokumatiageruWord:
                                                            !controller
                                                                .isManualSavedWordPage,
                                                      );
                                                    },
                                                    backgroundColor:
                                                        const Color(0xFFFE4A49),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    label: '삭제',
                                                  ),
                                                ],
                                              ),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: controller
                                                          .selectedWord[index]
                                                          .isKnown
                                                      ? AppColors.correctColor
                                                      : AppColors.lightGrey,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    left: Responsive.height10 *
                                                        0.4,
                                                  ),
                                                ),
                                                onPressed: () => Get.to(
                                                  () => MyVocaStduySCreen(
                                                      index: index),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                        height: Responsive
                                                            .height10),
                                                    SizedBox(
                                                      height:
                                                          Responsive.height10 *
                                                              5,
                                                      child: Center(
                                                          child: Text(
                                                        controller.isWordFlip
                                                            ? controller
                                                                .selectedWord[
                                                                    index]
                                                                .mean
                                                            : controller
                                                                .selectedWord[
                                                                    index]
                                                                .word,
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .scaffoldBackground,
                                                            fontSize: Responsive
                                                                .width18,
                                                            fontFamily: AppFonts
                                                                .japaneseFont),
                                                      )),
                                                    ),
                                                    if (controller
                                                            .selectedWord[index]
                                                            .createdAt !=
                                                        null)
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Text(
                                                          '${controller.selectedWord[index].createdAtString()} 에 저장됨',
                                                          style: TextStyle(
                                                            fontSize: Responsive
                                                                .height14,
                                                          ),
                                                        ),
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
                            ],
                          );
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
}

class PPPPPP extends StatelessWidget {
  const PPPPPP({super.key});

  @override
  Widget build(BuildContext context) {
    bool isKnwonCheck = true;
    bool isUnKnwonCheck = true;
    String errorMessage = '';
    MyVocaController controller = Get.find<MyVocaController>();
    return ValueListenableBuilder<List<MyWord>>(
        valueListenable: controller.selectedEvents,
        builder: (context, value, _) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text('테스트 종류를 선택 해주세요.',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '미암기 단어',
                          style: TextStyle(
                            color: AppColors.scaffoldBackground,
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                            value: isUnKnwonCheck,
                            onChanged: (value) {
                              setState(() {
                                isUnKnwonCheck = !isUnKnwonCheck;
                              });
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '암기한 단어',
                          style: TextStyle(
                            color: AppColors.scaffoldBackground,
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                            value: isKnwonCheck,
                            onChanged: (value) {
                              setState(() {
                                isKnwonCheck = !isKnwonCheck;
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
                            List<MyWord> tempMyWord = [];

                            if (isKnwonCheck && isUnKnwonCheck) {
                              tempMyWord = value;
                            } else if (isKnwonCheck && !isUnKnwonCheck) {
                              for (MyWord myWord in value) {
                                if (myWord.isKnown) {
                                  tempMyWord.add(myWord);
                                }
                              }
                            } else if (!isKnwonCheck && isUnKnwonCheck) {
                              for (MyWord myWord in value) {
                                if (!myWord.isKnown) {
                                  tempMyWord.add(myWord);
                                }
                              }
                            } else {
                              setState(() {
                                errorMessage = '테스트 종류를 선택 해주세요.';
                              });
                              return;
                            }

                            if (tempMyWord.length < 4) {
                              setState(() {
                                errorMessage = '테스트 단어 개수가 4개 이상 이어야 합니다.';
                              });
                              return;
                            }
                            Get.toNamed(
                              JLPT_TEST_PATH,
                              arguments: {MY_VOCA_TEST: tempMyWord},
                            );
                          },
                          child: const Text('테스트 하기')),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
