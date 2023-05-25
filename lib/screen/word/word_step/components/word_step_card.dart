import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:japanese_voca/model/word_step.dart';

import '../../../../config/colors.dart';

class WordStepCard extends StatelessWidget {
  const WordStepCard({
    Key? key,
    required this.jlptStep,
    required this.onTap,
  }) : super(key: key);

  final JlptStep jlptStep;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
          onTap: onTap,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(
                'assets/svg/calender.svg',
                color: jlptStep.scores == jlptStep.words.length
                    ? AppColors.lightGreen
                    : Colors.white,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: width / 20),
                  Padding(
                    padding: EdgeInsets.only(top: width / 30),
                    child: Text((jlptStep.step + 1).toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontSize: (width / 10), color: Colors.white)),
                  ),
                  SizedBox(height: width / 100),
                  Center(
                    child: Text(
                      '${jlptStep.scores.toString()} / ${jlptStep.words.length}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: width / 40, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
