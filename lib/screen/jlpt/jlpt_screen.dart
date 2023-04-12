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
  GrammarController grammarController = Get.put(GrammarController());
  // Get.put(JlptWordController(level: index));

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
    grammarController.setGrammarSteps('1');
  }

  @override
  Widget build(BuildContext context) {
    Get.put(JlptWordController(level: widget.level));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'N${widget.level} 단어장',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: items[currentPageIndex],
      bottomNavigationBar: widget.level == '1'
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
