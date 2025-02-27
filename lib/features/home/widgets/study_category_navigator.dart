import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        KindOfStudy.values.length,
        (index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: size.width / 3.5,
              height: 35,
              decoration: BoxDecoration(
                border: index == currentPageIndex
                    ? Border(
                        bottom: BorderSide(
                          width: 3,
                          color: Colors.cyan.shade600,
                        ),
                      )
                    : null,
              ),
              child: Center(
                  child: Text(
                '${KindOfStudy.values[index].value} 단어장',
                style: index == currentPageIndex
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade600,
                      )
                    : TextStyle(
                        color: Colors.grey.shade600,
                      ),
              )),
            ),
          );
        },
      ),
    );
  }
}
