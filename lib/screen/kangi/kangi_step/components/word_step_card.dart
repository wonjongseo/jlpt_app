import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:japanese_voca/model/kangi_step.dart';

import '../../../../../config/colors.dart';

class KangiStepCard extends StatelessWidget {
  const KangiStepCard({
    Key? key,
    required this.kangiStep,
    required this.onTap,
  }) : super(key: key);

  final KangiStep kangiStep;
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
                color: kangiStep.scores == kangiStep.kangis.length
                    ? AppColors.lightGreen
                    : Colors.black87,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: width / 20),
                  Padding(
                    padding: EdgeInsets.only(top: width / 30),
                    child: Text((kangiStep.step + 1).toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: (width / 10))),
                  ),
                  SizedBox(height: width / 100),
                  Center(
                    child: Text(
                      '${kangiStep.scores.toString()} / ${kangiStep.kangis.length}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: width / 40,
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
