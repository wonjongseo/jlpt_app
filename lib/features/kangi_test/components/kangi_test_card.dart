import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';

import '../controller/kangi_test_controller.dart';
import '../../../model/Question.dart';
import 'kangi_question_option.dart';

class KangiQuestionCard extends StatelessWidget {
  KangiQuestionCard({super.key, required this.question});

  final Question question;
  final KangiTestController controller = Get.find<KangiTestController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Text(
            question.question.word,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xFF101010),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.japaneseFont,
                ),
          ),
          SizedBox(height: Responsive.height10),
          if (controller.isKangiSubject)
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.height8,
                    ),
                    child: const Tooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      message:
                          '1. 읽는 법을 입력하면 사지선다가 표시됩니다.\n2. 장음 (-, ー) 은 생략해도 됩니다.',
                      child: Icon(
                        Icons.help,
                        size: 16,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  hintText: '읽는 법을 먼저 입력해주세요.',
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  label: Text(
                    ' 읽는 법',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground.withOpacity(0.5),
                      fontSize: Responsive.height16,
                    ),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppFonts.japaneseFont,
                ),
              ),
            ),
          Row(
            children: [
              if (!controller.isKangiSubject) _selectKangi(),
              SizedBox(width: Responsive.width10),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '음독',
                      style: TextStyle(
                          color: AppColors.scaffoldBackground,
                          fontSize: Responsive.height14),
                    ),
                    Column(
                        children: List.generate(
                      question.options.length,
                      (index) {
                        return GetBuilder<KangiTestController>(
                            builder: (controller1) {
                          Color getTheRightColor2() {
                            if (controller1.isAnswered2) {
                              if (question
                                      .options[controller1.randumIndexs[index]]
                                      .yomikata
                                      .split('@')[0] ==
                                  controller1.correctAns2) {
                                return const Color(0xFF6AC259);
                              } else if (question
                                          .options[
                                              controller1.randumIndexs[index]]
                                          .yomikata
                                          .split('@')[0] ==
                                      controller1.selectedAns2 &&
                                  question
                                          .options[
                                              controller1.randumIndexs[index]]
                                          .yomikata
                                          .split('@')[0] !=
                                      controller1.correctAns2) {
                                return const Color(0xFFE92E30);
                              }
                            }
                            return AppColors.scaffoldBackground
                                .withOpacity(0.5);
                          }

                          return KangiQuestionOption(
                            text: question
                                        .options[
                                            controller1.randumIndexs[index]]
                                        .yomikata
                                        .split('@')[0] ==
                                    '-'
                                ? '없음'
                                : question
                                    .options[controller1.randumIndexs[index]]
                                    .yomikata
                                    .split('@')[0],
                            color: getTheRightColor2(),
                            isAnswered: controller1.isAnswered2,
                            question: question,
                            index: index,
                            press: controller1.isAnswered2
                                ? () {}
                                : () => controller1.checkAns(
                                    question,
                                    question
                                        .options[
                                            controller1.randumIndexs[index]]
                                        .yomikata
                                        .split('@')[0],
                                    'undoc'),
                          );
                        });
                      },
                    )),
                  ],
                ),
              ),
              SizedBox(width: Responsive.width10),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '훈독',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                        fontSize: Responsive.height14,
                      ),
                    ),
                    Column(
                      children: List.generate(
                        question.options.length,
                        (index) {
                          return GetBuilder<KangiTestController>(
                            builder: (controller1) {
                              Color getTheRightColor2() {
                                if (controller1.isAnswered3) {
                                  if (question
                                          .options[
                                              controller1.randumIndexs2[index]]
                                          .yomikata
                                          .split('@')[1] ==
                                      controller1.correctAns3) {
                                    return const Color(0xFF6AC259);
                                  } else if (question
                                              .options[controller1
                                                  .randumIndexs2[index]]
                                              .yomikata
                                              .split('@')[1] ==
                                          controller1.selectedAns3 &&
                                      question
                                              .options[controller1
                                                  .randumIndexs2[index]]
                                              .yomikata
                                              .split('@')[1] !=
                                          controller1.correctAns3) {
                                    return const Color(0xFFE92E30);
                                  }
                                }
                                return AppColors.scaffoldBackground
                                    .withOpacity(0.5);
                              }

                              return KangiQuestionOption(
                                text: question
                                            .options[controller1
                                                .randumIndexs2[index]]
                                            .yomikata
                                            .split('@')[1] ==
                                        '-'
                                    ? '없음'
                                    : question
                                        .options[
                                            controller1.randumIndexs2[index]]
                                        .yomikata
                                        .split('@')[1],
                                color: getTheRightColor2(),
                                isAnswered: controller1.isAnswered3,
                                question: question,
                                index: index,
                                press: controller1.isAnswered3
                                    ? () {}
                                    : () => controller1.checkAns(
                                        question,
                                        question
                                            .options[controller1
                                                .randumIndexs2[index]]
                                            .yomikata
                                            .split('@')[1],
                                        'hundoc'),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _selectKangi() {
    return Expanded(
      child: Column(
        children: [
          Text(
            '한자',
            style: TextStyle(
              color: AppColors.scaffoldBackground,
              fontSize: Responsive.height14,
            ),
          ),
          Column(
              children: List.generate(
            question.options.length,
            (index) => GetBuilder<KangiTestController>(builder: (controller1) {
              Color getTheRightColor() {
                if (controller1.isAnswered1) {
                  if (question.options[index].mean == controller1.correctAns) {
                    return const Color(0xFF6AC259);
                  } else if (question.options[index].mean ==
                          controller1.selectedAns &&
                      question.options[index].mean != controller1.correctAns) {
                    return const Color(0xFFE92E30);
                  }
                }
                return AppColors.scaffoldBackground.withOpacity(0.5);
              }

              return KangiQuestionOption(
                text: question.options[index].mean,
                color: getTheRightColor(),
                isAnswered: controller1.isAnswered1,
                question: question,
                index: index,
                press: controller1.isAnswered1
                    ? null
                    : () => controller1.checkAns(
                          question,
                          question.options[index].mean,
                          'hangul',
                        ),
              );
            }),
          )),
        ],
      ),
    );
  }
}
