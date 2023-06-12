import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/banner_ad_contrainer.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/controller/my_voca_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/ad_controller.dart';
import '../../common/admob/banner_ad/banner_ad_controller.dart';
import '../../common/excel.dart';
import '../../controller/user_controller.dart';
import '../jlpt/jlpt_quiz/jlpt_quiz_screen.dart';
import 'components/my_word_input_field.dart';
import 'components/upload_excel_infomation.dart';

const MY_VOCA_PATH = '/my_voca';

// ignore: must_be_immutable
class MyVocaPage extends StatelessWidget {
  late BannerAdController? bannerAdController;

  MyVocaPage({super.key}) {
    isSeenTutorial = LocalReposotiry.isSeenMyWordTutorial();
    isManual = Get.arguments[MY_VOCA_TYPE] == MyVocaEnum.MY_WORD ? true : false;
    myVocaController = Get.put(
      MyVocaController(isManual: isManual),
    );

    if (!userController.user.isPremieum) {
      adController = Get.find<AdController>();
      bannerAdController = Get.find<BannerAdController>();
      if (!bannerAdController!.loadingCalendartBanner) {
        bannerAdController!.loadingCalendartBanner = true;
        bannerAdController!.createCalendarBanner();
      }
    }
  }
  late bool isSeenTutorial;
  late bool isManual;

  UserController userController = Get.find<UserController>();
  late AdController? adController;
  late MyVocaController myVocaController;

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.changeFunc(context);
          },
          label: Icon(
            Icons.flip,
            key: controller.myVocaTutorialService?.flipKey,
          ),
          // child: Text('Excel'),
        ),
        bottomNavigationBar: GetBuilder<BannerAdController>(
          builder: (controller) {
            return BannerContainer(bannerAd: controller.calendarBanner);
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(),
          title: InkWell(
            key: controller.myVocaTutorialService?.calendarTextKey,
            onTap: controller.flipCalendar,
            child: Text(isManual ? '나만의 단어' : '자주 틀리는 문제'),
          ),
          actions: [
            if (isManual)
              IconButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      content: MyWordInputField(
                        key: controller.myVocaTutorialService?.inputIconKey,
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
                ),
              ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isManual)
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
                                  onPressed: () {
                                    Get.back(result: true);
                                  },
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
                          await postExcelData();
                        }
                      },
                    ),
                  if (controller.myWords.length >= 4)
                    TextButton(
                      onPressed: () {
                        bool a = true;
                        bool b = true;
                        Get.dialog(
                          StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: const Text.rich(TextSpan(
                                  text: '테스트 종류를 선택 해주세요.\n',
                                  children: [
                                    TextSpan(
                                      text: '테스트 단어 개수가 4개 이상 이어야 합니다.',
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                  style: TextStyle(
                                    color: AppColors.scaffoldBackground,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '미암기 단어',
                                          style: TextStyle(
                                            color: AppColors.scaffoldBackground,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Checkbox(
                                            value: b,
                                            onChanged: (value) {
                                              setState(() {
                                                b = !b;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '암기한 단어',
                                          style: TextStyle(
                                            color: AppColors.scaffoldBackground,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Checkbox(
                                            value: a,
                                            onChanged: (value) {
                                              setState(() {
                                                a = !a;
                                              });
                                            }),
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            JLPT_QUIZ_PATH,
                                            arguments: {
                                              MY_VOCA_TEST: controller.myWords,
                                              MY_VOCA_TEST_KNOWN: a,
                                              MY_VOCA_TEST_UNKNWON: b,
                                            },
                                          );
                                        },
                                        child: const Text('테스트 하기'))
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'TEST',
                        style: TextStyle(
                          color: AppColors.whiteGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                                  onPressed: () => controller.clickMyWord(
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
                                              color: Colors.black,
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
}
