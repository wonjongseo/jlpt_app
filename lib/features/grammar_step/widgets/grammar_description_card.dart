import 'package:flutter/cupertino.dart';
import 'package:japanese_voca/config/colors.dart';

class GrammarDescriptionCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
        const SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(
            // color: AppColors.whiteGrey,
            fontSize: fontSize - 2,
          ),
        )
      ],
    );
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
          ),
          const TextSpan(text: ' :\n'),
          TextSpan(
            text: content,
            style: TextStyle(
              color: AppColors.whiteGrey,
              fontSize: fontSize,
            ),
          )
        ],
      ),
    );
  }
}
