import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/home/kangi_headtitle_screen.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/home/jlpt_level_sceen.dart';
import 'package:japanese_voca/screen/home/grammar_level_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_screen_old.dart';

import 'components/home_navigator_button.dart';

// ignore: constant_identifier_names
const String HOME_PATH = '/home';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  late bool isSeenTutorial;
  late HomeTutorialService? homeTutorialService = null;
  @override
  initState() {
    super.initState();
    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
    if (!isSeenTutorial) {
      homeTutorialService = HomeTutorialService();
      homeTutorialService?.initTutorial();
      homeTutorialService?.showTutorial(context);
    }
  }

  List<Widget> items = [
    Container(),
    const GrammarLevelScreen(),
    const KangiHangulScreen(),
    const MyVocaSceen(),
  ];

  void changePage(int page) {
    currentPage = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        onTap: changePage,
        items: [
          const BottomNavigationBarItem(
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
                key: homeTutorialService?.grammarKey,
                '문법',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
          const BottomNavigationBarItem(
              icon: Text(
                '한자',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Text(
                key: homeTutorialService?.myVocaKey,
                'MY',
                style: const TextStyle(
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
            WelcomeWidget(settingKey: homeTutorialService?.settingKey),
            currentPage == 0
                ? JlptLevelSceen(
                    jlptN1Key: homeTutorialService?.jlptN1Key,
                    isSeenHomeTutorial: isSeenTutorial)
                : items[currentPage]
          ],
        ),
      ),
    );
  }
}

class MyVocaSceen extends StatelessWidget {
  const MyVocaSceen({super.key});

  void addExcelData() async {
    var excel = Excel.createExcel();
    List<String> dataList = ['일본어', '읽는 법', '뜻'];

    Sheet sheetObject = excel['Sheet1'];
    sheetObject.insertRowIterables(dataList, 0);

    excel.rename('Sheet1', 'jonggack');

    if (GetPlatform.isWeb) {
      var fileBytes = await excel.save(fileName: 'jonggack_app.xlsx');
    }

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
