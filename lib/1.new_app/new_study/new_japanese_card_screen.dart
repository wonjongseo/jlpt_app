import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/1.new_app/new_study/components/new_custom_appbar.dart';
import 'package:japanese_voca/1.new_app/new_study/components/new_japanese_card.dart';
import 'package:japanese_voca/1.new_app/models/new_japanese.dart';
import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';

class NewJapaneseCardScreen extends StatefulWidget {
  const NewJapaneseCardScreen(
      {super.key, this.isRelated = false, required this.index});
  final bool isRelated;
  final int index;
  @override
  State<NewJapaneseCardScreen> createState() => _NewJapaneseCardScreenState();
}

class _NewJapaneseCardScreenState extends State<NewJapaneseCardScreen> {
  JlptStudyController jlptStudyController = Get.find<JlptStudyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isRelated ? AppBar() : null,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          CustomAppBar(currentIndex: jlptStudyController.currentIndex),
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              onPageChanged: jlptStudyController.onPageChanged,
              // controller: jlptStudyController.pageController,
              itemCount: jlptStudyController.words.length,
              itemBuilder: (context, index) {
                return NewJapaneseCard(
                  japanese: jlptStudyController.words[index],
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
