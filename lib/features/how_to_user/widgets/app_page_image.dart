import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';

class AppPageImage extends StatelessWidget {
  const AppPageImage({super.key, required this.imageName});

  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          imageName.split('.png')[0],
          style: const TextStyle(
            color: AppColors.scaffoldBackground,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Responsive.height40),
        Container(
          width: double.infinity / 1.5,
          height: 400,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/$imageName',
            ),
          )),
        ),
      ],
    );
  }
}
