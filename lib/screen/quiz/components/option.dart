import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/word.dart';

class Option extends StatelessWidget {
  const Option(
      {Key? key, required this.test, required this.index, required this.press})
      : super(key: key);

  final Question test;
  final int index;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (index == qnController.correctAns) {
                return Color(0xFF6AC259);
              } else if (index == qnController.selectedAns &&
                  index != qnController.correctAns) {
                return Color(0xFFE92E30);
              }
            }
            return Color(0xFFC1C1C1);
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == Color(0xFFE92E30)
                ? Icons.close
                : Icons.done;
          }

          return qnController.isWrong
              ? OptionCard(getTheRightColor, getTheRightIcon)
              : InkWell(
                  onTap: press,
                  child: OptionCard(getTheRightColor, getTheRightIcon));
        });
  }

  Container OptionCard(Color getTheRightColor(), IconData getTheRightIcon()) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${index + 1} ${test}',
            style: TextStyle(color: getTheRightColor(), fontSize: 16),
          ),
          Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                  color: getTheRightColor() == Color(0xFFC1C1C1)
                      ? Colors.transparent
                      : getTheRightColor(),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: getTheRightColor())),
              child: getTheRightColor() == Color(0xFFC1C1C1)
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
