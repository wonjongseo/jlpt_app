import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class UserWordButton extends StatelessWidget {
  const UserWordButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.totalCount,
    this.textKey,
  });

  final Function() onTap;
  final String text;
  final int totalCount;
  final Key? textKey;

  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        // height: 50,
        decoration: BoxDecoration(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              key: textKey,
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
