import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

import '../../config/colors.dart';
import 'animated_circular_progressIndicator.dart';

class PartOfInformation extends StatelessWidget {
  const PartOfInformation({
    super.key,
    required this.edgeInsets,
    required this.text,
    this.curCnt,
    this.totalCnt,
    this.onPressed,
  });
  final String text;
  final EdgeInsets edgeInsets;

  final int? curCnt;
  final int? totalCnt;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.height20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            from: 100,
            child: Text(
              text,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: Responsive.width14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInLeft(
                from: 100,
                child: SizedBox(
                  height: Responsive.height45,
                  width: Responsive.width165,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteGrey,
                      padding:
                          EdgeInsets.symmetric(horizontal: Responsive.width16),
                    ),
                    child: Text(
                      '학습 하기',
                      style: TextStyle(
                        fontSize: Responsive.height14,
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
                      Text(
                        '진행률',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.height11,
                        ),
                      ),
                      Row(
                        children: [
                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: curCnt! / 100),
                            duration: const Duration(milliseconds: 1500),
                            builder: (context, value, child) {
                              return Text(
                                (value * 100).ceil().toString(),
                                style: TextStyle(
                                  fontSize: Responsive.height14,
                                ),
                              );
                            },
                          ),
                          Text(
                            ' / ',
                            style: TextStyle(
                              fontSize: Responsive.height14,
                            ),
                          ),
                          Text(
                            totalCnt.toString(),
                            style: TextStyle(
                              fontSize: Responsive.height14,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: Responsive.width15),
                  SizedBox(
                    height: Responsive.height60,
                    width: Responsive.height60,
                    child: AnimatedCircularProgressIndicator(
                      currentProgressCount: curCnt,
                      totalProgressCount: totalCnt,
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
