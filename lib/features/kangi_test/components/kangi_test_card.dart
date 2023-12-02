import 'dart:math';

import 'package:flutter/material.dart';
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
      margin: EdgeInsets.symmetric(horizontal: Dimentions.width20),
      padding: EdgeInsets.symmetric(
          horizontal: Dimentions.width20, vertical: Dimentions.height20),
      decoration: const BoxDecoration(
        color: AppColors.whiteGrey,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
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
          const SizedBox(height: 20 / 2),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '한자',
                        style: TextStyle(color: AppColors.scaffoldBackground),
                      ),
                      Column(
                          children: List.generate(
                        question.options.length,
                        (index) => GetBuilder<KangiTestController>(
                            builder: (controller1) {
                          Color getTheRightColor() {
                            if (controller1.isAnswered1) {
                              if (question.options[index].mean ==
                                  controller1.correctAns) {
                                return const Color(0xFF6AC259);
                              } else if (question.options[index].mean ==
                                      controller1.selectedAns &&
                                  question.options[index].mean !=
                                      controller1.correctAns) {
                                return const Color(0xFFE92E30);
                              }
                            }
                            return AppColors.scaffoldBackground
                                .withOpacity(0.5);
                          }

                          return KangiQuestionOption(
                            text: question.options[index].mean,
                            color: getTheRightColor(),
                            isAnswered: controller1.isAnswered1,
                            question: question,
                            index: index,
                            press: controller1.isAnswered1
                                ? () {}
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
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '음독',
                        style: TextStyle(color: AppColors.scaffoldBackground),
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
                                        .options[
                                            controller1.randumIndexs[index]]
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
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        '훈독',
                        style: TextStyle(color: AppColors.scaffoldBackground),
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
                                          .options[
                                              controller1.randumIndexs2[index]]
                                          .yomikata
                                          .split('@')[1] ==
                                      '-'
                                  ? '없음'
                                  : question
                                      .options[controller1.randumIndexs2[index]]
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
                                          .options[
                                              controller1.randumIndexs2[index]]
                                          .yomikata
                                          .split('@')[1],
                                      'hundoc'),
                            );
                          });
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
