import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/common/repository/local_repository.dart';
import 'package:japanese_voca/entity/my_voca/controller/my_voca_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/admob/controller/ad_controller.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../common/excel.dart';
import '../user/controller/user_controller.dart';
import '../jlpt_and_kangi/jlpt/jlpt_test/jlpt_test_screen.dart';
import 'components/my_word_input_field.dart';
import 'components/upload_excel_infomation.dart';

const MY_VOCA_PATH = '/my_voca';

// ignore: must_be_immutable
class MyVocaPage extends StatelessWidget {
  UserController userController = Get.find<UserController>();
  late AdController? adController;
  late MyVocaController myVocaController;

  MyVocaPage({super.key}) {
    isSeenTutorial = LocalReposotiry.isSeenMyWordTutorial();
    myVocaController = Get.put(
      MyVocaController(
          isManual:
              Get.arguments[MY_VOCA_TYPE] == MyVocaEnum.MY_WORD ? true : false),
    );
  }

  late bool isSeenTutorial;

  @override
  Widget build(BuildContext context) {
    if (!isSeenTutorial) {
      myVocaController.showTutirial(context);
    }
    Size size = MediaQuery.of(context).size;

    double responsiveWordBoxHeight = size.width > 700 ? 130 : 50;
    double responsiveTextFontSize = size.width > 700 ? 30 : 18;

    final kFirstDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month - 3, myVocaController.kToday.day);
    final kLastDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month + 3, myVocaController.kToday.day);

    return GetBuilder<MyVocaController>(builder: (controller) {
      return Scaffold(
        floatingActionButton: _floatingActionButton(controller, context),
        bottomNavigationBar: GetBuilder<BannerAdController>(
          builder: (controller) {
            return BannerContainer(bannerAd: controller.calendarBanner);
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          title: InkWell(
            key: controller.myVocaTutorialService?.calendarTextKey,
            onTap: controller.flipCalendar,
            child: Text(controller.isManual ? '나만의 단어' : '자주 틀리는 문제'),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.flip,
                key: controller.myVocaTutorialService?.flipKey,
              ),
              onPressed: () => controller.openDialogForchangeFunc(context),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (controller.isManual)
                    TextButton(
                      child: Text(
                        'EXCEL',
                        style: const TextStyle(
                          color: AppColors.whiteGrey,
                          fontWeight: FontWeight.bold,
                        ),
                        key: controller.myVocaTutorialService?.excelMyVocaKey,
                      ),
                      onPressed: () async {
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        );
                        if (result != null) {
                          if (!userController.user.isPremieum) {
                            adController!.showIntersistialAd();
                          }
                          int savedWordNumber = await postExcelData();
                          if (savedWordNumber != 0) {
                            Get.offNamed(
                              MY_VOCA_PATH,
                              arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                              preventDuplicates: false,
                            );
                          }
                        }
                      },
                    ),
                  const SizedBox(width: 10),
                  if (controller.isManual)
                    IconButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            content: MyWordInputField(
                              key: controller
                                  .myVocaTutorialService?.inputIconKey,
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
                      icon: Icon(
                        key: controller.myVocaTutorialService?.inputIconKey,
                        Icons.brush,
                        color: AppColors.whiteGrey,
                      ),
                    ),
                  const SizedBox(width: 10),
                ],
              ),
              if (controller.isCalendarOpen)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Material(
                    textStyle:
                        const TextStyle(color: AppColors.scaffoldBackground),
                    color: AppColors.whiteGrey,
                    child: TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: controller.focusedDay,
                      calendarFormat: controller.calendarFormat,
                      eventLoader: controller.getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
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
              if (controller.isCalendarOpen) const Divider(height: 40),
              Expanded(
                child: ValueListenableBuilder<List<MyWord>>(
                  valueListenable: controller.selectedEvents,
                  builder: (context, value, _) {
                    return SingleChildScrollView(
                      child: Column(
                        children: List.generate(
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
                                key: index == 0
                                    ? controller
                                        .myVocaTutorialService?.myVocaTouchKey
                                    : null,
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        value[index].isKnown == true
                                            ? controller.updateWord(
                                                value[index].word, false)
                                            : controller.updateWord(
                                                value[index].word, true);
                                      },
                                      backgroundColor: Colors.blueAccent,
                                      foregroundColor: Colors.white,
                                      icon: Icons.check,
                                      label: value[index].isKnown == true
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
                                        controller.myWords.remove(value[index]);
                                        controller.deleteWord(
                                          value[index],
                                        );
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: '삭제',
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: value[index].isKnown
                                        ? AppColors.correctColor
                                        : AppColors.whiteGrey,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero,
                                    ),
                                    padding: const EdgeInsets.only(left: 4),
                                  ),
                                  onPressed: () =>
                                      controller.openDialogForclickMyWord(
                                    context,
                                    value[index],
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        height: responsiveWordBoxHeight,
                                        child: Center(
                                            child: Text(
                                          controller.isWordFlip
                                              ? value[index].mean
                                              : value[index].word,
                                          style: TextStyle(
                                              color:
                                                  AppColors.scaffoldBackground,
                                              fontSize: responsiveTextFontSize,
                                              fontFamily:
                                                  AppFonts.japaneseFont),
                                        )),
                                      ),
                                      if (value[index].createdAt != null)
                                        Align(
                                          alignment: Alignment.bottomRight,
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
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  FloatingActionButton? _floatingActionButton(
      MyVocaController controller, BuildContext context) {
    if (controller.myWords.length >= 4) {
      return FloatingActionButton.extended(
        onPressed: () {
          bool isKnwonCheck = true;
          bool isUnKnwonCheck = true;
          String errorMessage = '';
          Get.dialog(
            StatefulBuilder(
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
                                tempMyWord = controller.myWords;
                              } else if (isKnwonCheck && !isUnKnwonCheck) {
                                for (MyWord myWord in controller.myWords) {
                                  if (myWord.isKnown) {
                                    tempMyWord.add(myWord);
                                  }
                                }
                              } else if (!isKnwonCheck && isUnKnwonCheck) {
                                for (MyWord myWord in controller.myWords) {
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
                                arguments: {
                                  MY_VOCA_TEST: tempMyWord,
                                },
                              );
                            },
                            child: const Text('테스트 하기')),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
        label: const Text(
          '시험 보기',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return null;
    }
  }
}
