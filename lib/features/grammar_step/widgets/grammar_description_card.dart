import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';

class GrammarDescriptionCard extends StatefulWidget {
  const GrammarDescriptionCard({
    Key? key,
    required this.title,
    required this.content,
    required this.fontSize,
  }) : super(key: key);

  final String title;
  final String content;
  final double fontSize;

  @override
  State<GrammarDescriptionCard> createState() => _GrammarDescriptionCardState();
}

class _GrammarDescriptionCardState extends State<GrammarDescriptionCard> {
  bool isSeen = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: widget.fontSize),
            ),
            IconButton(
              onPressed: () {
                isSeen = !isSeen;
                setState(() {});
              },
              icon: Icon(
                size: 32,
                isSeen
                    ? Icons.arrow_drop_up_rounded
                    : Icons.arrow_drop_down_rounded,
              ),
            ),
          ],
        ),
        if (isSeen)
          Text(
            widget.content,
            style: TextStyle(
              fontFamily: AppFonts.descriptionFont,
              fontSize: widget.fontSize - 2,
            ),
          ),
        if (isSeen) SizedBox(height: Responsive.height10 * 1.5),
      ],
    );
  }
}
