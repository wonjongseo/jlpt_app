import 'package:flutter/material.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/widgets/step_selector_button.dart';

class TopNavigationBtn extends StatelessWidget {
  const TopNavigationBtn(
      {super.key,
      required this.stepList,
      required this.navigationKey,
      required this.onTap,
      required this.isCurrent,
      required this.isFinished});

  final List stepList;
  final GlobalKey<State<StatefulWidget>> Function(int) navigationKey;
  final Function(int) onTap;
  final bool Function(int) isCurrent;
  final bool? Function(int) isFinished;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(stepList.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                key: navigationKey(index),
                onTap: () => onTap(index),
                child: StepSelectorButton(
                  isCurrent: isCurrent(index),
                  isFinished: isFinished(index),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
