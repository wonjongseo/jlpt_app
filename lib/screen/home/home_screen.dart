import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

final String HOME_PATH = '/home';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void goTo(String index) {
    Get.to(() => JlptScreen(level: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: const Text('종각 JLPT'),
      //   // actions: [
      //   //   TextButton(
      //   //       onPressed: () {
      //   //         launchUrl(
      //   //           Uri.parse('mailto:visionwill3322@gmail.com'),
      //   //         );
      //   //       },
      //   //       child: const Text(
      //   //         '버그신고',
      //   //       ))
      //   // ],
      // ),
      drawer: _drawer(),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ),
              CustomPageButton(onTap: () => goTo('1'), level: 'N11'),
              CustomPageButton(onTap: () => goTo('2'), level: 'N2'),
              CustomPageButton(onTap: () => goTo('3'), level: 'N3'),
              CustomPageButton(onTap: () => goTo('4'), level: 'N4'),
              CustomPageButton(onTap: () => goTo('5'), level: 'N5'),
            ],
          ),
        ),
      ),
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
              '모두 시험 준비 화이팅입니다!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(MY_VOCA_PATH);
            },
            leading: const Icon(Icons.person),
            title: const Text('나만의 일본어 단어'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(SETTING_PATH);
            },
            leading: const Icon(Icons.settings),
            title: const Text('설정'),
          ),
        ],
      ),
    );
  }
}
