import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class KangiButton extends StatelessWidget {
  const KangiButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.onTap,
  });

  final double height;
  final double width;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.width15,
          ),
        ),
      ),
    );
  }
}
