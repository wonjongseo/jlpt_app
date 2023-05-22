import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';

final String HOME_PATH = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPage = 0;
  List<Widget> items = const [
    WordScreen(),
    GrammarScreen(),
    MyVocaSceen(),
  ];
  void changePage(int page) {
    currentPage = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: const [
          BottomNavigationBarItem(
              icon: Text(
                '단어',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Text(
                '문법',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Text(
                'MY',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
        ],
      ),
      body: SafeArea(
        child: Column(
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
                padding:
                    // const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    const EdgeInsets.only(
                        top: 16, bottom: 16, left: 32, right: 16),
                child: FadeInDown(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'こんにちは！',
                            style: GoogleFonts.abel(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Text(
                                'ようこそ',
                                style: GoogleFonts.abel(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ' JLPT 종각 APP',
                                style: GoogleFonts.abel(
                                    color: Colors.red,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => Get.toNamed(SETTING_PATH),
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
            items[currentPage]
          ],
        ),
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
    this.wordsCount,
  }) : super(key: key);

  final Duration delay;
  final String text;
  final String? wordsCount;
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
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    if (wordsCount != null)
                      Text(
                        '$wordsCount개',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class WordScreen extends StatelessWidget {
  const WordScreen({super.key});
  void goTo(String index) {
    Get.to(
      () => JlptScreen(level: index),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LevelSelectCard(
              delay: const Duration(milliseconds: 0),
              text: 'N1 단어',
              wordsCount: '2,466',
              onTap: () => goTo('1')),
          LevelSelectCard(
              wordsCount: '2,618',
              delay: const Duration(milliseconds: 300),
              text: 'N2 단어',
              onTap: () => goTo('2')),
          LevelSelectCard(
              wordsCount: '1,532',
              delay: const Duration(milliseconds: 500),
              text: 'N3 단어',
              onTap: () => goTo('3')),
          LevelSelectCard(
              wordsCount: '1,029',
              delay: const Duration(milliseconds: 700),
              text: 'N4 단어',
              onTap: () => goTo('4')),
          LevelSelectCard(
              wordsCount: '737',
              delay: const Duration(milliseconds: 900),
              text: 'N5 단어',
              onTap: () => goTo('5')),
        ],
      ),
    );
  }
}

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});
  void goTo(String index) {
    Get.to(
      () => JlptScreen(level: index),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LevelSelectCard(
            delay: const Duration(milliseconds: 0),
            text: 'N1 문법',
            wordsCount: '237',
            onTap: () => Get.to(
              () => const GrammarStepSceen(
                level: '1',
              ),
            ),
          ),
          LevelSelectCard(
              delay: const Duration(milliseconds: 300),
              text: 'N2 문법',
              wordsCount: '93',
              onTap: () => Get.to(
                    () => const GrammarStepSceen(
                      level: '2',
                    ),
                  )),
          LevelSelectCard(
              delay: const Duration(milliseconds: 500),
              text: 'N3 문법',
              wordsCount: '106',
              onTap: () => Get.to(
                    () => const GrammarStepSceen(
                      level: '3',
                    ),
                  )),
        ],
      ),
    );
  }
}

class MyVocaSceen extends StatelessWidget {
  const MyVocaSceen({super.key});
  void goTo(String index) {
    Get.to(
      () => JlptScreen(level: index),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void addExcelData() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
      allowMultiple: false,
    );

    int savedWordNumber = 0;
    int alreadySaveWordNumber = 0;
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
          } else {
            alreadySaveWordNumber++;
          }
          // savedWords.add(newWord);

        }
      }
      Get.snackbar(
        '성공',
        '$savedWordNumber개의 단어가 저장되었습니다. ($alreadySaveWordNumber개의 단어가 이미 저장되어 있습니다.)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white.withOpacity(0.5),
        duration: const Duration(seconds: 1),
        animationDuration: const Duration(seconds: 1),
      );
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LevelSelectCard(
              delay: const Duration(milliseconds: 0),
              text: '나만의 단어 보기',
              onTap: () {
                Get.back();
                Get.toNamed(MY_VOCA_PATH);
              }),
          LevelSelectCard(
              text: 'Excel로 단어 저장하기',
              delay: const Duration(milliseconds: 300),
              onTap: () => addExcelData()),
        ],
      ),
    );
  }
}
