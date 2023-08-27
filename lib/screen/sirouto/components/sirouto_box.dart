import 'package:flutter/material.dart';
import 'package:japanese_voca/config/colors.dart';

class SiroutoBox extends StatelessWidget {
  const SiroutoBox({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: AppColors.whiteGrey,
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.scaffoldBackground,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
