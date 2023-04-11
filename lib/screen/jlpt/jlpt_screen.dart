import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
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

  List<Widget> items = const [
    WordHiraganaStepScreen(),
    GrammarStepSceen(),
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'JLPT N1 단어장',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                child: Text(
              'Hello Everyone !',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )),
            ListTile(
              onTap: () => Get.toNamed(MY_VOCA_PATH),
              leading: const Icon(Icons.person),
              title: const Text('My Voca'),
            ),
            ListTile(
              onTap: () => Get.toNamed(SETTING_PATH),
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
            )
          ],
        ),
      ),
      body: items[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(
              icon: Text('단어',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              label: ''),
          BottomNavigationBarItem(
              icon: Text('문법',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              label: ''),
        ],
      ),
    );
  }
}
