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
    const GrammarStepSceen(),
  ];

  void changePage(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Get.put(JlptWordController(level: widget.level));

    if (widget.level == '1' || widget.level == '2' || widget.level == '3') {
      Get.put(GrammarController(level: widget.level));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('N${widget.level} 단어장'),
      ),
      body: items[currentPageIndex],
      bottomNavigationBar:
          widget.level == '1' || widget.level == '2' || widget.level == '3'
              ? BottomNavigationBar(
                  currentIndex: currentPageIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: changePage,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Text('단어',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Text('문법',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        label: ''),
                  ],
                )
              : null,
    );
  }
}
