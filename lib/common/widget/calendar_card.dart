import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import '../../../../config/colors.dart';

class CalendarCard extends StatelessWidget {
  const CalendarCard({
    Key? key,
    required this.jlptStep,
    required this.onTap,
    required this.isAabled,
  }) : super(key: key);

  final JlptStep jlptStep;
  final VoidCallback onTap;
  final bool isAabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 4),
      child: InkWell(
        onTap: isAabled ? onTap : null,
        child: Container(
          height: Responsive.height10 * 5,
          padding: EdgeInsets.all(Responsive.height16 / 2),
          margin: EdgeInsets.all(Responsive.height16 / 2),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: isAabled
                ? jlptStep.scores == jlptStep.words.length
                    ? AppColors.lightGreen
                    : Colors.white
                : Colors.black.withOpacity(0.05),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: Responsive.height18,
                  color:
                      isAabled ? Colors.black : Colors.white.withOpacity(0.1),
                ),
                children: [
                  TextSpan(text: 'Chater ${(jlptStep.step + 1)} '),
                  TextSpan(
                    text: '(${jlptStep.scores} / ${jlptStep.words.length})',
                    style: TextStyle(
                      fontSize: Responsive.height17,
                      color: isAabled
                          ? Colors.grey
                          : Colors.white.withOpacity(0.1),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KangiCalendarCard extends StatelessWidget {
  const KangiCalendarCard({
    Key? key,
    required this.kangiStep,
    required this.onTap,
    required this.isAabled,
  }) : super(key: key);

  final KangiStep kangiStep;
  final VoidCallback onTap;
  final bool isAabled;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 4),
        child: InkWell(
          onTap: isAabled ? onTap : null,
          child: Container(
            height: Responsive.height10 * 0.5,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: isAabled
                  ? kangiStep.scores == kangiStep.kangis.length
                      ? AppColors.lightGreen
                      : Colors.white
                  : Colors.black.withOpacity(0.05),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: (width / 20),
                    color:
                        isAabled ? Colors.black : Colors.white.withOpacity(0.1),
                  ),
                  children: [
                    TextSpan(text: 'Chater ${(kangiStep.step + 1)} '),
                    TextSpan(
                      text:
                          '(${kangiStep.scores} / ${kangiStep.kangis.length})',
                      style: TextStyle(
                        fontSize: width / 25,
                        color: isAabled
                            ? Colors.grey
                            : Colors.white.withOpacity(0.1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
