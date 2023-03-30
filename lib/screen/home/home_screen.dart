import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/network.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_selection_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_page.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
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
    JlptScreen(level: '1'),
    //JlptSelectionScreen(),
    MyVocaPage(),
    TranslatorPage()
  ];

  void changePage(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('N1'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(SETTING_PATH),
              icon: const Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          NetWork netWork = NetWork();
          await netWork.getDictinoal(word: '바보');
        },
        child: Text('FIND'),
      ),
      body: items[currentPageIndex],
    );
  }
}
