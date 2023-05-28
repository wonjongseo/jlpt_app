import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/screen/my_voca/services/my_voca_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/my_word_input_field.dart';

const MY_VOCA_PATH = '/my_voca';

// ignore: must_be_immutable
class MyVocaPage extends StatelessWidget {
  MyVocaPage({super.key}) {
    isSeenTutorial = LocalReposotiry.isSeenMyWordTutorial();
  }
  late bool isSeenTutorial;
  MyVocaController myVocaController = Get.put(MyVocaController());

  @override
  Widget build(BuildContext context) {
    print('asdfsdf');
    // if (true) {
    myVocaController.showTutirial(context);
    // }
    Size size = MediaQuery.of(context).size;

    double responsiveWordBoxHeight = size.width > 700 ? 130 : 55;
    double responsiveTextFontSize = size.width > 700 ? 25 : 18;

    final kFirstDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month - 3, myVocaController.kToday.day);
    final kLastDay = DateTime(myVocaController.kToday.year,
        myVocaController.kToday.month + 3, myVocaController.kToday.day);

    return GetBuilder<MyVocaController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(
            color: Colors.white,
          ),
          title: const Text('나만의 단어'),
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    content: MyWordInputField(
                      key: controller.myVocaTutorialService?.inputIconKey,
                      saveWord: controller.saveWord,
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
                  Icons.brush),
            ),
            IconButton(
              onPressed: () {
                controller.changeFunc(context);
              },
              icon: Icon(
                Icons.flip,
                key: controller.myVocaTutorialService?.flipKey,
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
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
              const Divider(height: 40),
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
                                  horizontal: 10, vertical: 10),
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
                                        controller.updateWord(value[index]);
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                  onPressed: () {
                                    controller.clickMyWord(
                                        context, value[index]);
                                  },
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
                                          ),
                                        )),
                                      ),
                                      if (value[index].createdAt != null)
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            '${value[index].createdAtString()} 에 저장됨',
                                          ),
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
