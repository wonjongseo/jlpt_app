import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.book,
            color: Colors.white,
            size: 220,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          level,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        )
      ],
    );
  }
}
