import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';
import 'package:japanese_voca/screen/word/word_hiragana_step/word_hiragana_step_screen.dart';

final String JLPT_PATH = '/';

class JlptScreen extends StatefulWidget {
  const JlptScreen({super.key, required this.level});

  final String level;

  @override
  State<JlptScreen> createState() => _JlptScreenState();
}

class _JlptScreenState extends State<JlptScreen> {
  int currentPageIndex = 0;

  List<Widget> items = [
    const WordHiraganaStepScreen(),
  ];

  void changePage(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Get.put(JlptWordController(level: widget.level));

    if (widget.level == '1' || widget.level == '2' || widget.level == '3') {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text('N${widget.level} 단어'),
      ),
      body: const WordHiraganaStepScreen(),
    );
  }
}
