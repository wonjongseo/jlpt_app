import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

class KangiButton extends StatelessWidget {
  const KangiButton({
    super.key,
    this.width = 95,
    this.height = 40,
    required this.text,
    required this.onTap,
  });

  final double height;
  final double width;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimentions.height50,
      width: Dimentions.width90,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimentions.width14,
          ),
        ),
      ),
    );
  }
}
