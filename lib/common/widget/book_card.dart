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
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: SvgPicture.asset(
              'assets/svg/hiragana_book.svg',
              height: 220,
              color: Colors.black87,
            ),
          ),
          Text(
            level,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          )
        ],
      ),
    );
  }
}
