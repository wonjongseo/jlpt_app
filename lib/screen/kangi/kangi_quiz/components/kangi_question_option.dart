import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/controller/kangi_question_controller.dart';
import 'package:japanese_voca/model/Question.dart';

class KangiQuestionOption extends StatelessWidget {
  const KangiQuestionOption(
      {Key? key,
      required this.question,
      required this.index,
      required this.press,
      required this.isAnswered,
      required this.color,
      required this.text})
      : super(key: key);

  // final Word test;
  final bool isAnswered;
  final int index;
  final Question question;
  final VoidCallback press;
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    List<String> multMean = text.split(',');
    Size size = MediaQuery.of(context).size;

    return GetBuilder<KangiQuestionController>(
      init: KangiQuestionController(),
      builder: (qnController) {
        Container optionCard(
            Color color, IconData Function() getTheRightIcon, Size size) {
          return Container(
            margin: const EdgeInsets.only(top: 20.0),
            padding: const EdgeInsets.all(8.0),
            height: size.height * 0.1,
            decoration: BoxDecoration(
                border: Border.all(color: color),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: multMean.length == 1
                        ? Text(
                            text,
                            style: TextStyle(color: color, fontSize: 14),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              multMean.length,
                              (index) => Text(
                                '${index + 1}. ${multMean[index].trim()}',
                                style: TextStyle(color: color, fontSize: 14),
                              ),
                            ),
                          ),
                  ),
                ),
                Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                      color: color == const Color(0xFFC1C1C1)
                          ? Colors.transparent
                          : color,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: color)),
                  child: color == const Color(0xFFC1C1C1)
                      ? null
                      : Icon(
                          getTheRightIcon(),
                          size: 8,
                        ),
                ),
              ],
            ),
          );
        }

        IconData getTheRightIcon() {
          return color == const Color(0xFFE92E30) ? Icons.close : Icons.done;
        }

        return qnController.isWrong
            ? optionCard(color, getTheRightIcon, size)
            : InkWell(
                onTap: press,
                child: optionCard(color, getTheRightIcon, size),
              );
      },
    );
  }
}
