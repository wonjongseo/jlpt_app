import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      // alignment: AlignmentDirectional.center,
      children: [
        InkWell(
          onTap: onTap,
          child: SvgPicture.asset(
            'assets/svg/book_open.svg',
            height: 220,
            color: Colors.white,
          ),
        ),
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
