import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class StepSelectorButton extends StatelessWidget {
  const StepSelectorButton({
    super.key,
    this.isFinished,
    required this.isCurrent,
  });

  final bool isCurrent;
  // final bool isEnabled;
  final bool? isFinished;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrent ? AppColors.mainColor : Colors.cyan.shade200,
      elevation: isCurrent ? 3 : 0,
      child: Container(
        width: Responsive.height10 * 8.5, //
        padding: EdgeInsets.all(Responsive.height8),
        child: isCurrent
            ? Icon(
                Icons.star,
                color: AppColors.primaryColor,
                size: Responsive.height10 * 1.6,
              )
            : isFinished ?? false
                ? Icon(
                    FontAwesomeIcons.check,
                    size: Responsive.height10 * 1.6,
                  )
                : Icon(
                    FontAwesomeIcons.lockOpen,
                    size: Responsive.height10 * 1.6,
                  ),
      ),
    );
  }
}
