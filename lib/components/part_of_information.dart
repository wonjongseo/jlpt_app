import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/colors.dart';
import 'animated_circular_progressIndicator.dart';

class PartOfInformation extends StatelessWidget {
  const PartOfInformation({
    super.key,
    required this.edgeInsets,
    required this.text,
    this.currentProgressCount,
    this.totalProgressCount,
    this.goToSutdy,
  });
  final String text;
  final EdgeInsets edgeInsets;

  final int? currentProgressCount;
  final int? totalProgressCount;
  final Function()? goToSutdy;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInLeft(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: FadeInLeft(
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: goToSutdy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteGrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text(
                      '학습 하러 가기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 2),
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(
                                begin: 0, end: currentProgressCount! / 100),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, value, child) {
                              return Text(
                                (value * 100).ceil().toString(),
                                style: const TextStyle(fontSize: 14),
                              );
                            },
                          ),
                          const Text(' / '),
                          Text(
                            totalProgressCount.toString(),
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: Container(
                      margin: edgeInsets,
                      child: AnimatedCircularProgressIndicator(
                        currentProgressCount: currentProgressCount,
                        totalProgressCount: totalProgressCount,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
