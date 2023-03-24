import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:japanese_voca/screen/word/n_word_screen.dart';

final String JLPT_PATH = '/jlpt';

class JlptScreen extends StatefulWidget {
  const JlptScreen({super.key, required this.level});

  final String level;

  @override
  State<JlptScreen> createState() => _JlptScreenState();
}

class _JlptScreenState extends State<JlptScreen> {
  int currentPageIndex = 0;

  List<Widget> items = const [
    NWordScreen(),
    GrammarScreen(),
  ];

  void changePage(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('N${widget.level}'),
        elevation: 0,
      ),
      body: items[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: [
          BottomNavigationBarItem(
              icon: Text('단어',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              label: ''),
          BottomNavigationBarItem(
              icon: Text('문법',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              label: ''),
        ],
      ),
    );
  }
}
