import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Responsive.height15),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: Responsive.height15),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height16,
            color: AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
