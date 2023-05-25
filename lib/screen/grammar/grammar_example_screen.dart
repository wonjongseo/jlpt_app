import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/model/example.dart';

class GrammarExampleCard extends StatefulWidget {
  const GrammarExampleCard({super.key, required this.example});
  final Example example;
  @override
  State<GrammarExampleCard> createState() => _GrammarExampleCardState();
}

class _GrammarExampleCardState extends State<GrammarExampleCard> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double fontSize = size.width > 700 ? 17 : 14;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TouchableJapanese(
                  underlineColor: Colors.black,
                  japanese: widget.example.word,
                  clickTwice: false,
                  fontSize: fontSize,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      isClick = !isClick;
                      setState(() {});
                    },
                    icon: SvgPicture.asset(
                      'assets/svg/eye.svg',
                      color: Colors.white,
                      width: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        copyWord(widget.example.word);
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
          if (isClick)
            Text(
              widget.example.mean,
              style: TextStyle(color: Colors.grey, fontSize: fontSize - 2),
            ),
        ],
      ),
    );
  }
}
