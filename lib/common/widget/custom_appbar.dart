import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/size.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle(
      {super.key, required this.curIndex, required this.totalIndex});

  final int curIndex;
  final int totalIndex;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: appBarTextSize),
        children: [
          TextSpan(
            text: '$curIndex',
            style: TextStyle(
              color: Colors.cyan.shade500,
              fontSize: Responsive.height10 * 2.5,
            ),
          ),
          const TextSpan(text: ' / '),
          TextSpan(text: '$totalIndex')
        ],
      ),
    );
  }
}
