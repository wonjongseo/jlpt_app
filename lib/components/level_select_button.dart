import 'package:flutter/material.dart';

import '../config/colors.dart';

List<String> jlptLevels = ['N1', 'N2', 'N3', 'N4', 'N5'];

class LevelSelectButton extends StatelessWidget {
  const LevelSelectButton({
    super.key,
    required this.currentPageIndex,
    required this.pageChange,
  });

  final int currentPageIndex;
  final Function(int) pageChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          jlptLevels.length,
          (index) => ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
              backgroundColor:
                  index == currentPageIndex ? AppColors.primaryColor : null,
            ),
            onPressed: () {
              pageChange(index);
            },
            child: Text(
              jlptLevels[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
