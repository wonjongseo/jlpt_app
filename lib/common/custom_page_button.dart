import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPageButton extends StatelessWidget {
  const CustomPageButton({
    Key? key,
    required this.onTap,
    required this.level,
  }) : super(key: key);

  final VoidCallback onTap;
  final String level;
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
              color: Colors.black,
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
