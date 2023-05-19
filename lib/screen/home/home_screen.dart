import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:url_launcher/url_launcher.dart';

final String HOME_PATH = '/home';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void goTo(String index) {
    Get.to(() => JlptScreen(level: index),
        transition: Transition.leftToRight,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: const Text('종각 JLPT'),
      //   actions: [
      //     TextButton(
      //         onPressed: () {
      //           launchUrl(
      //             Uri.parse('mailto:visionwill3322@gmail.com'),
      //           );
      //         },
      //         child: const Text(
      //           '버그신고',
      //         ))
      //   ],
      // ),
      endDrawer: _drawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.18,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: FadeInDown(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'こんにちは！',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(fontSize: 26, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ようこそ JLPT 종각 APP',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        icon: const Icon(
                          Icons.settings,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LevelSelectCard(
                    delay: const Duration(milliseconds: 0),
                    text: 'N1',
                    wordsCount: '2,466',
                    onTap: () => goTo('1')),
                LevelSelectCard(
                    wordsCount: '2,618',
                    delay: const Duration(milliseconds: 300),
                    text: 'N2',
                    onTap: () => goTo('2')),
                LevelSelectCard(
                    wordsCount: '1,532',
                    delay: const Duration(milliseconds: 500),
                    text: 'N3',
                    onTap: () => goTo('3')),
                LevelSelectCard(
                    wordsCount: '1,029',
                    delay: const Duration(milliseconds: 700),
                    text: 'N4',
                    onTap: () => goTo('4')),
                LevelSelectCard(
                    wordsCount: '7,37',
                    delay: const Duration(milliseconds: 900),
                    text: 'N5',
                    onTap: () => goTo('5')),
                // LevelSelectCard(
                //     delay: const Duration(milliseconds: 1100),
                //     text: 'MY',
                //     onTap: () => goTo('1')),
              ],
            ),
          )
        ],
      ),

      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CustomPageButton(onTap: () => goTo('1'), level: 'N1'),
      //       CustomPageButton(onTap: () => goTo('2'), level: 'N2'),
      //       CustomPageButton(onTap: () => goTo('3'), level: 'N3'),
      //       CustomPageButton(onTap: () => goTo('4'), level: 'N4'),
      //       CustomPageButton(onTap: () => goTo('5'), level: 'N5'),
      //     ],
      //   ),
      // ),
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
            onTap: () async {
              FilePickerResult? pickedFile =
                  await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['xlsx'],
                withData: true,
                allowMultiple: false,
              );

              int savedWordNumber = 0;
              if (pickedFile != null) {
                var bytes = pickedFile.files.single.bytes;

                var excel = Excel.decodeBytes(bytes!);

                for (var table in excel.tables.keys) {
                  for (var row in excel.tables[table]!.rows) {
                    print('-------------------------------');

                    String word = (row[0] as Data).value.toString();
                    String yomikata = (row[1] as Data).value.toString();
                    String mean = (row[2] as Data).value.toString();

                    MyWord newWord = MyWord(
                      word: word,
                      mean: mean,
                      yomikata: yomikata,
                    );

                    print('newWord: ${newWord}');
                    if (LocalReposotiry.saveMyWord(newWord)) {
                      savedWordNumber++;
                    }
                    // savedWords.add(newWord);

                  }
                }
                Get.snackbar(
                  '성공',
                  '$savedWordNumber개의 단어가 저장되었습니다.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 1),
                  animationDuration: const Duration(seconds: 1),
                );
              } else {
                // User canceled the picker
              }
            },
            leading: const Icon(Icons.person),
            title: const Text('파일로 나만의 일본어 단어 추가'),
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

class LevelSelectCard extends StatelessWidget {
  const LevelSelectCard({
    Key? key,
    required this.delay,
    required this.text,
    required this.onTap,
    required this.wordsCount,
  }) : super(key: key);

  final Duration delay;
  final String text;
  final String wordsCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: FadeInLeft(
        delay: delay,
        child: InkWell(
          onTap: onTap,
          child: Container(
              height: 50,
              width: size.width * 0.7,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1, 1),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.button,
                    ),
                    Text(
                      '$wordsCount개',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
