import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import '../../../../config/colors.dart';

class JlptCalendarCard extends StatelessWidget {
  const JlptCalendarCard({
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
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
          onTap: isAabled ? onTap : null,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(
                'assets/svg/calender.svg',
                color: isAabled
                    ? jlptStep.scores == jlptStep.words.length
                        ? AppColors.lightGreen
                        : Colors.white
                    : Colors.white.withOpacity(0.1),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: width / 20),
                  Padding(
                    padding: EdgeInsets.only(top: width / 30),
                    child: Text((jlptStep.step + 1).toString(),
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: (width / 10),
                                  color: isAabled
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.1),
                                )),
                  ),
                  SizedBox(height: width / 100),
                  Center(
                    child: Text(
                      '${jlptStep.scores.toString()} / ${jlptStep.words.length}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: width / 35,
                            color: isAabled
                                ? Colors.white
                                : Colors.white.withOpacity(0.1),
                          ),
                    ),
                  )
                ],
              )
            ],
          )),
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
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
          onTap: onTap,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(
                'assets/svg/calender.svg',
                color: isAabled
                    ? kangiStep.scores == kangiStep.kangis.length
                        ? AppColors.lightGreen
                        : Colors.white
                    : Colors.white.withOpacity(0.1),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: width / 20),
                  Padding(
                    padding: EdgeInsets.only(top: width / 30),
                    child: Text((kangiStep.step + 1).toString(),
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: (width / 10),
                                  color: isAabled
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.1),
                                )),
                  ),
                  SizedBox(height: width / 100),
                  Center(
                    child: Text(
                      '${kangiStep.scores.toString()} / ${kangiStep.kangis.length}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: width / 40,
                            color: isAabled
                                ? Colors.white
                                : Colors.white.withOpacity(0.1),
                          ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
