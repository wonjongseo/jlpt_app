import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/network.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_selection_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
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
    JlptSelectionScreen(),
    MyVocaPage(),
  ];

  void changePage(int index) {
    currentPageIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JLPT 단어장'),
      ),
      drawer: _drawer(),
      body: const JlptSelectionScreen(),
    );
  }

  Drawer _drawer() {
    return Drawer(
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
            onTap: () {
              Get.back();
              Get.toNamed(MY_VOCA_PATH);
            },
            leading: const Icon(Icons.person),
            title: const Text('My Voca'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(SETTING_PATH);
            },
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          )
        ],
      ),
    );
  }
}
