import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';

import '../jlpt_study_controller.dart';

// ignore: must_be_immutable
class JlptStrudyCard extends StatelessWidget {
  JlptStrudyCard({
    Key? key,
    // required this.controller,
  }) : super(key: key);

  // final JlptStudyController controller;

  JlptStudyController controller = Get.find<JlptStudyController>();

  @override
  Widget build(BuildContext context) {
    String japanese = controller.words[controller.currentIndex].word;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(child: controller.yomikata()),
        KangiText(japanese: japanese, clickTwice: false),
        const SizedBox(height: 20),
        SizedBox(child: controller.mean()),
      ],
    );
  }
}
