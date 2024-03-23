import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';

import '../../../config/theme.dart';

class GrammarExampleCard extends StatefulWidget {
  const GrammarExampleCard(
      {super.key, required this.example, required this.index});
  final Example example;
  final int index;
  @override
  State<GrammarExampleCard> createState() => _GrammarExampleCardState();
}

class _GrammarExampleCardState extends State<GrammarExampleCard> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    double fontSize = Responsive.width15;

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.height16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                if (!isClick) {
                  isClick = true;
                  setState(() {});
                }
              },
              child: Text(
                '${widget.index + 1}. ${widget.example.word}',
                style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: AppFonts.japaneseFont,
                ),
              )),
          if (isClick)
            ZoomIn(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  widget.example.mean,
                  style: TextStyle(
                      color: Colors.grey, fontSize: Responsive.width14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
