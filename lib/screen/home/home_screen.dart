import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_selection_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_page.dart';
import 'package:japanese_voca/screen/translator/translator_page.dart';

final String HOME_PATH = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  List<Widget> items = const [
    JlptSelectionScreen(),
    MyVocaPage(),
    // TranslatorPage()
  ];

  void changePage(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: items[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/book.svg', height: 30),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/svg/pencil.svg', height: 30),
              label: ''),
        ],
      ),
    );
  }
}
