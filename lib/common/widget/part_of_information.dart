import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../screen/home/services/home_tutorial_service.dart';
import 'animated_circular_progressIndicator.dart';

class PartOfInformation extends StatelessWidget {
  const PartOfInformation({
    super.key,
    required this.edgeInsets,
    required this.text,
    this.currentProgressCount,
    this.totalProgressCount,
    this.goToSutdy,
    this.homeTutorialService,
  });
  final String text;
  final EdgeInsets edgeInsets;

  final int? currentProgressCount;
  final int? totalProgressCount;
  final Function()? goToSutdy;
  final HomeTutorialService? homeTutorialService;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            from: homeTutorialService == null ? 100 : 0,
            child: Text(
              key: homeTutorialService?.selectKey,
              text,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInLeft(
                from: homeTutorialService == null ? 100 : 0,
                child: SizedBox(
                  height: 45,
                  width: size.width * 0.4,
                  child: ElevatedButton(
                    onPressed: goToSutdy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      '학습 하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '진행률',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Row(
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(
                                begin: 0, end: currentProgressCount! / 100),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, value, child) {
                              return Text(
                                (value * 100).ceil().toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                          const Text(
                            ' / ',
                            style: TextStyle(),
                          ),
                          Text(
                            totalProgressCount.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: AnimatedCircularProgressIndicator(
                      key: homeTutorialService?.progressKey,
                      currentProgressCount: currentProgressCount,
                      totalProgressCount: totalProgressCount,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
