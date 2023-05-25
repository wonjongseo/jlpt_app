import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';

import '../jlpt_controller.dart';

class JlptStrudyCard extends StatelessWidget {
  const JlptStrudyCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final JlptStudyController controller;

  @override
  Widget build(BuildContext context) {
    String japanese = controller.words[controller.currentIndex].word;
    // [0,2]
    return Column(
      children: [
        SizedBox(child: controller.yomikata),
        KangiText(japanese: japanese, clickTwice: false),
        const SizedBox(height: 20),
        SizedBox(child: controller.mean),
      ],
    );
  }
}
