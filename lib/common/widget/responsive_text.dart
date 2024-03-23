import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

class ResponsiveText extends StatelessWidget {
  const ResponsiveText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: Responsive.height14),
    );
  }
}
