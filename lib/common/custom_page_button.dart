import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPageButton extends StatelessWidget {
  const CustomPageButton({
    Key? key,
    required this.onTap,
    required this.level,
    this.isAble = true,
  }) : super(key: key);

  final VoidCallback onTap;
  final String level;
  final bool isAble;
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

  //return InkWell(
  //nTap: onTap,

  //child: Container(
  // height: 50,
  // margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
  // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
  // decoration: const BoxDecoration(
  //   image: DecorationImage(
  //     image: AssetImage('assets/images/open_book.png'),
  //     fit: BoxFit.fitHeight,
  //   ),

  // color: Colors.white,
  // borderRadius: BorderRadius.circular(8),
  // boxShadow: const [
  //   BoxShadow(
  //       offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.5),
  // ],
  // ),
  // child: Center(
  //   child: Text(
  //     level,
  //     style: Theme.of(context)
  //         .textTheme
  //         .bodyLarge
  //         ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
  //   ),
  // ),
  //,
  //
  //}
}
