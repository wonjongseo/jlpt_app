import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/home/widgets/home_screen_body.dart';

class StudyCategoryNavigator extends StatelessWidget {
  const StudyCategoryNavigator(
      {super.key, required this.onTap, required this.currentPageIndex});

  final Function(int) onTap;
  final int currentPageIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height10 * 4,
      child: BottomNavigationBar(
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        onTap: onTap,
        items: List.generate(
          KindOfStudy.values.length,
          (index) => BottomNavigationBarItem(
            icon: Container(
              decoration: index == currentPageIndex
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Colors.cyan.shade700,
                        ),
                      ),
                    )
                  : null,
              child: Text(
                KindOfStudy.values[index].name,
                style: index == currentPageIndex
                    ? TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan.shade700,
                        fontSize: Responsive.height20,
                      )
                    : TextStyle(
                        fontSize: Responsive.height14,
                      ),
              ),
            ),
            label: KindOfStudy.values[index].name,
          ),
        ),
      ),
    );
  }
}
