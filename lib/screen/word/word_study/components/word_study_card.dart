import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';

import '../word_controller.dart';

class WordStrudyCard extends StatelessWidget {
  const WordStrudyCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WordStudyController controller;

  @override
  Widget build(BuildContext context) {
    String japanese = controller.words[controller.currentIndex].word;
    List<int> kangiIndex = getKangiIndex(japanese);
    // [0,2]
    return Column(
      children: [
        SizedBox(child: controller.yomikata),
        KangiText(japanese: japanese, clickTwice: false),
        const SizedBox(height: 15),
        SizedBox(child: controller.mean),
      ],
    );
  }
}
