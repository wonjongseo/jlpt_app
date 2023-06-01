import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';

import '../../../../controller/kangi_question_controller.dart';
import '../../../../model/Question.dart';
import 'kangi_question_option.dart';

class KangiQuestionCard extends StatelessWidget {
  KangiQuestionCard({super.key, required this.question});

  final Question question;
  final KangiQuestionController controller =
      Get.find<KangiQuestionController>();

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    List<int> randumIndexs = [];

    for (int i = 0; randumIndexs.length < 4; i++) {
      int temp = random.nextInt(4);

      if (randumIndexs.contains(temp)) continue;

      randumIndexs.add(temp);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      color: AppColors.whiteGrey,
      child: Column(
        children: [
          Text(
            question.question.word,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color(0xFF101010),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
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
                      const Text('한자'),
                      Column(
                          children: List.generate(
                        question.options.length,
                        (index) => GetBuilder<KangiQuestionController>(
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
                            return const Color(0xFFC1C1C1);
                          }

                          return KangiQuestionOption(
                            text: question.options[index].mean,
                            color: getTheRightColor(),
                            isAnswered: controller1.isAnswered1,
                            question: question,
                            index: index,
                            press: () => controller1.checkAns(question,
                                question.options[index].mean, 'hangul'),
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
                      const Text('음독'),
                      Column(
                          children: List.generate(
                        question.options.length,
                        (index) {
                          return GetBuilder<KangiQuestionController>(
                              builder: (controller1) {
                            Color getTheRightColor2() {
                              if (controller1.isAnswered2) {
                                if (question
                                        .options[randumIndexs[index]].yomikata
                                        .split('@')[0] ==
                                    controller1.correctAns2) {
                                  return const Color(0xFF6AC259);
                                } else if (question.options[randumIndexs[index]]
                                            .yomikata
                                            .split('@')[0] ==
                                        controller1.selectedAns2 &&
                                    question.options[randumIndexs[index]]
                                            .yomikata
                                            .split('@')[0] !=
                                        controller1.correctAns2) {
                                  return const Color(0xFFE92E30);
                                }
                              }
                              return const Color(0xFFC1C1C1);
                            }

                            return KangiQuestionOption(
                              text: question
                                          .options[randumIndexs[index]].yomikata
                                          .split('@')[0] ==
                                      '-'
                                  ? '없음'
                                  : question
                                      .options[randumIndexs[index]].yomikata
                                      .split('@')[0],
                              color: getTheRightColor2(),
                              isAnswered: controller1.isAnswered2,
                              question: question,
                              index: index,
                              press: () => controller1.checkAns(
                                  question,
                                  question.options[randumIndexs[index]].yomikata
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
                      Text('훈독'),
                      Column(
                          children: List.generate(
                        question.options.length,
                        (index) {
                          return GetBuilder<KangiQuestionController>(
                              builder: (controller1) {
                            Color getTheRightColor2() {
                              if (controller1.isAnswered3) {
                                if (question
                                        .options[randumIndexs[index]].yomikata
                                        .split('@')[1] ==
                                    controller1.correctAns3) {
                                  return const Color(0xFF6AC259);
                                } else if (question.options[randumIndexs[index]]
                                            .yomikata
                                            .split('@')[1] ==
                                        controller1.selectedAns3 &&
                                    question.options[randumIndexs[index]]
                                            .yomikata
                                            .split('@')[1] !=
                                        controller1.correctAns3) {
                                  return const Color(0xFFE92E30);
                                }
                              }
                              return const Color(0xFFC1C1C1);
                            }

                            return KangiQuestionOption(
                              text: question
                                          .options[randumIndexs[index]].yomikata
                                          .split('@')[1] ==
                                      '-'
                                  ? '없음'
                                  : question
                                      .options[randumIndexs[index]].yomikata
                                      .split('@')[1],
                              color: getTheRightColor2(),
                              isAnswered: controller1.isAnswered3,
                              question: question,
                              index: index,
                              press: () => controller1.checkAns(
                                  question,
                                  question.options[randumIndexs[index]].yomikata
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
