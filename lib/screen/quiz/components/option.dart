import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/word.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key, required this.test, required this.index, required this.press})
      : super(key: key);

  final Word test;
  final int index;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          String getString() {
            if (qnController.isKorean) {
              if (qnController.isAnswered) {
                return '${test.mean}\n${test.yomikata}';
              }

              return test.mean;
            } else {
              if (qnController.isAnswered) {
                return '${test.yomikata}\n${test.mean}';
              }

              return test.yomikata;
            }
          }

          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (index == qnController.correctAns) {
                return const Color(0xFF6AC259);
              } else if (index == qnController.selectedAns &&
                  index != qnController.correctAns) {
                return const Color(0xFFE92E30);
              }
            }
            return const Color(0xFFC1C1C1);
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == const Color(0xFFE92E30)
                ? Icons.close
                : Icons.done;
          }

          return qnController.isWrong
              ? optionCard(getTheRightColor, getTheRightIcon, getString)
              : InkWell(
                  onTap: press,
                  child:
                      optionCard(getTheRightColor, getTheRightIcon, getString));
        });
  }

  Container optionCard(Color Function() getTheRightColor,
      IconData Function() getTheRightIcon, String Function() getString) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${index + 1} ${getString()}',
              style: TextStyle(color: getTheRightColor(), fontSize: 16),
            ),
          ),
          Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                  color: getTheRightColor() == const Color(0xFFC1C1C1)
                      ? Colors.transparent
                      : getTheRightColor(),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: getTheRightColor())),
              child: getTheRightColor() == const Color(0xFFC1C1C1)
                  ? null
                  : Icon(
                      getTheRightIcon(),
                      size: 16,
                    )),
        ],
      ),
    );
  }
}