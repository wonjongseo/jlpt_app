import 'package:flutter/material.dart';
import 'package:japanese_voca/config/colors.dart';

class HomeNaviatorButton extends StatelessWidget {
  const HomeNaviatorButton({
    Key? key,
    required this.text,
    required this.currentProgressCount,
    this.onTap,
    required this.totalProgressCount,
    this.jlptN1Key,
  }) : super(key: key);

  final GlobalKey? jlptN1Key;
  final String text;
  final int totalProgressCount;
  final int currentProgressCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: SizedBox(
        width: size.width * 0.75,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: totalProgressCount != currentProgressCount
                ? AppColors.whiteGrey
                : AppColors.correctColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key: jlptN1Key,
                    text,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 3),
                  Text.rich(
                    TextSpan(
                      text: currentProgressCount.toString(),
                      children: [
                        const TextSpan(text: ' / '),
                        TextSpan(text: totalProgressCount.toString())
                      ],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      color: AppColors.scaffoldBackground,
                      value: (currentProgressCount / totalProgressCount),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${((currentProgressCount / totalProgressCount) * 100).ceil().toString()} %',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
