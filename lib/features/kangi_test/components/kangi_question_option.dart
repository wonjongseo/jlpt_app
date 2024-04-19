import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/kangi_test/controller/kangi_test_controller.dart';
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

    if (multMean.length > 3) {
      multMean = multMean.sublist(0, 3);
    }
    return GetBuilder<KangiTestController>(
      init: KangiTestController(),
      builder: (qnController) {
        Container optionCard(
            Color color, IconData Function() getTheRightIcon, Size size) {
          return Container(
            margin: EdgeInsets.only(top: Responsive.height10 * 2),
            padding: EdgeInsets.all(Responsive.height16 / 2),
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
                        ? Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: color,
                                fontSize: Responsive.height14,
                              ),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              multMean.length,
                              (index) => Center(
                                child: Text(
                                  '${index + 1} ${multMean[index].trim()}',
                                  style: TextStyle(
                                    color: color,
                                    fontSize: Responsive.height14,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
