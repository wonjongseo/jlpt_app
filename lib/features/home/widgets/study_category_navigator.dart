import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';

class StudyCategoryNavigator extends StatelessWidget {
  const StudyCategoryNavigator({
    super.key,
    required this.onTap,
    required this.currentPageIndex,
  });

  final Function(int) onTap;
  final int currentPageIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        KindOfStudy.values.length,
        (index) {
          return TextButton(
            onPressed: () => onTap(index),
            child: Container(
              decoration: BoxDecoration(
                border: index == currentPageIndex
                    ? Border(
                        bottom: BorderSide(
                          width: Responsive.width10 * 0.3,
                          color: Colors.cyan.shade600,
                        ),
                      )
                    : null,
              ),
              child: Text(
                '${KindOfStudy.values[index].value} ${AppString.book.tr}',
                style: index == currentPageIndex
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade600,
                        // fontSize: Responsive.width15,
                      )
                    : TextStyle(
                        color: Colors.grey.shade600,
                        // fontSize: Responsive.width14,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
