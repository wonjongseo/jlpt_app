import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/fool_home_sceen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';

import 'components/home_navigator_button.dart';

class IgnoreAndOpacitWidget extends StatelessWidget {
  const IgnoreAndOpacitWidget(
      {super.key, required this.child, required this.isSeenAppDesc});

  final Widget child;
  final bool isSeenAppDesc;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isSeenAppDesc,
      child: Opacity(
        opacity: isSeenAppDesc ? 0.5 : 1,
        child: child,
      ),
    );
  }
}

final String HOME_PATH = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  // bool isSeenAppDesc = true;

  GlobalKey grammarKey = GlobalKey();
  GlobalKey jlptN1Key = GlobalKey();
  GlobalKey welcomeKey = GlobalKey();
  List<TargetFocus> targets = [];

  @override
  void initState() {
    targets.add(
        TargetFocus(identify: "Target 1", keyTarget: welcomeKey, contents: [
      TargetContent(
          align: ContentAlign.bottom,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Titulo lorem ipsum",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));

    targets
        .add(TargetFocus(identify: "Target 2", keyTarget: jlptN1Key, contents: [
      TargetContent(
          align: ContentAlign.left,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Multiples content",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
      TargetContent(
          align: ContentAlign.top,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Multiples content",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));

    targets.add(
        TargetFocus(identify: "Target 3", keyTarget: grammarKey, contents: [
      TargetContent(
          align: ContentAlign.right,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Title lorem ipsum",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));
  }

  void showTutorial() {
    TutorialCoachMark(
      targets: targets, // List<TargetFocus>
      colorShadow: Colors.red, // DEFAULT Colors.black
      // alignSkip: Alignment.bottomRight,
      // textSkip: "SKIP",
      // paddingFocus: 10,
      // opacityShadow: 0.8,
      onClickTarget: (target) {
        print(target);
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print(target);
      },
      onSkip: () {
        print("skip");
      },
      onFinish: () {
        print("finish");
      },
    )..show(context: context);
  }

  List<Widget> items = [
    const GrammarScreen(),
    const MyVocaSceen(),
  ];

  void changePage(int page) {
    currentPage = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    showTutorial();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: [
          BottomNavigationBarItem(
              icon: Text(
                '단어',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Text(
                key: grammarKey,
                '문법',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Text(
                'MY',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //
      body: SafeArea(
        // 앱 설명
        child: Column(
          children: [
            Container(
              key: welcomeKey,
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
                padding: const EdgeInsets.only(
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
            currentPage == 0
                ? WordScreen(jlptN1Key: jlptN1Key)
                : items[currentPage]
          ],
        ),
      ),
    );
  }
}

class WordScreen extends StatefulWidget {
  const WordScreen({
    super.key,
    required this.jlptN1Key,
  });

  final GlobalKey jlptN1Key;
  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
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
          FadeInLeft(
            delay: const Duration(milliseconds: 0),
            child: HomeNaviatorButton(
                jlptN1Key: widget.jlptN1Key,
                text: 'N1 단어',
                wordsCount: '2,466',
                onTap: () => goTo('1')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton(
                wordsCount: '2,618', text: 'N2 단어', onTap: () => goTo('2')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 500),
            child: HomeNaviatorButton(
                wordsCount: '1,532', text: 'N3 단어', onTap: () => goTo('3')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 700),
            child: HomeNaviatorButton(
                wordsCount: '1,029', text: 'N4 단어', onTap: () => goTo('4')),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 900),
            child: HomeNaviatorButton(
                wordsCount: '737', text: 'N5 단어', onTap: () => goTo('5')),
          ),
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
          FadeInLeft(
            delay: const Duration(milliseconds: 0),
            child: HomeNaviatorButton(
              text: 'N1 문법',
              wordsCount: '237',
              onTap: () => Get.to(
                () => const GrammarStepSceen(
                  level: '1',
                ),
              ),
            ),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton(
                text: 'N2 문법',
                wordsCount: '93',
                onTap: () => Get.to(
                      () => const GrammarStepSceen(
                        level: '2',
                      ),
                    )),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 500),
            child: HomeNaviatorButton(
                text: 'N3 문법',
                wordsCount: '106',
                onTap: () => Get.to(
                      () => const GrammarStepSceen(
                        level: '3',
                      ),
                    )),
          ),
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
          String word = (row[0] as Data).value.toString();
          String yomikata = (row[1] as Data).value.toString();
          String mean = (row[2] as Data).value.toString();

          MyWord newWord = MyWord(
            word: word,
            mean: mean,
            yomikata: yomikata,
          );

          if (MyWordRepository.saveMyWord(newWord)) {
            savedWordNumber++;
          } else {
            alreadySaveWordNumber++;
          }
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
          FadeInLeft(
            delay: const Duration(milliseconds: 0),
            child: HomeNaviatorButton(
                text: '나만의 단어 보기',
                onTap: () {
                  Get.back();
                  Get.toNamed(MY_VOCA_PATH);
                }),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton(
                text: 'Excel로 단어 저장하기', onTap: () => addExcelData()),
          ),
        ],
      ),
    );
  }
}
