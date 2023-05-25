import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/tutorial_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.level,
    required this.onTap,
  }) : super(key: key);

  final String level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        InkWell(
          onTap: onTap,
          child: const Icon(
            // shadows: [
            //   Shadow(
            //     color: Colors.black,
            //     offset: Offset(7, 7),
            //     blurRadius: 2,
            //   )
            // ],
            Icons.book,
            color: Colors.white,
            size: 220,
          ),
        ),
        Positioned(
          bottom: 30,
          child: Text(
            level,
            style: TextStyle(
              color: AppColors.scaffoldBackground,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        )
      ],
    );
  }
}
