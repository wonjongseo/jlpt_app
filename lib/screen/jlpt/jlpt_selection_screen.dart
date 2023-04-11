import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';

final String VOCA_PATH = '/jlpt_select';

class JlptSelectionScreen extends StatefulWidget {
  const JlptSelectionScreen({super.key});

  @override
  State<JlptSelectionScreen> createState() => _JlptSelectionScreenState();
}

class _JlptSelectionScreenState extends State<JlptSelectionScreen> {
  void goTo(String index) {
    Get.put(JlptWordController(level: index));
    Get.to(() => JlptScreen(level: index));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPageButton(onTap: () => goTo('1'), level: 'N1', isAble: true),
          const SizedBox(height: 12),
          CustomPageButton(onTap: () => goTo('2'), level: 'N2', isAble: false),
          const SizedBox(height: 12),
          CustomPageButton(onTap: () => goTo('3'), level: 'N3', isAble: false),
          const SizedBox(height: 12),
          CustomPageButton(onTap: () => goTo('4'), level: 'N4', isAble: false),
          const SizedBox(height: 12),
          CustomPageButton(onTap: () => goTo('5'), level: 'N5', isAble: false),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
