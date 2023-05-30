import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/home/kangi_headtitle_screen.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/home/jlpt_level_sceen.dart';
import 'package:japanese_voca/screen/home/grammar_level_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';

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
  // ignore: avoid_init_to_null
  late HomeTutorialService? homeTutorialService = null;

  AdController adUnitController = Get.find<AdController>();
  @override
  initState() {
    super.initState();
    adUnitController.createBanner();

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
    if (!adUnitController.loadingBanner) {
      adUnitController.loadingBanner = true;
      adUnitController.createBanner();
    }
    return GetBuilder<AdController>(builder: (controller) {
      return Column(
        children: [
          Expanded(
            child: Scaffold(
              extendBody: true,
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomNavigationBar(
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
                ],
              ),
              body: SafeArea(
                // 앱 설명
                child: Column(
                  children: [
                    WelcomeWidget(settingKey: homeTutorialService?.settingKey),
                    currentPage == 0
                        ? JlptLevelSceen(
                            jlptN1Key: homeTutorialService?.jlptN1Key,
                            isSeenHomeTutorial: isSeenTutorial)
                        : items[currentPage],
                  ],
                ),
              ),
            ),
          ),
          if (adUnitController.banner != null)
            SizedBox(
              // color: Colors.green,
              width: adUnitController.banner!.size.width.toDouble(),
              height: adUnitController.banner!.size.height.toDouble(),
              child: AdWidget(
                ad: adUnitController.banner!,
              ),
            ),
        ],
      );
    });
  }
}

class MyVocaSceen extends StatelessWidget {
  const MyVocaSceen({super.key});

  Future<void> postExcelData() async {
    print('object');
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

      try {
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            // if (row[0] == null || row[1] == null || row[2] == null) continue;
            String word = (row[0] as Data).value.toString();
            String yomikata = (row[1] as Data).value.toString();
            String mean = (row[2] as Data).value.toString();

            MyWord newWord = MyWord(
              word: word,
              mean: mean,
              yomikata: yomikata,
            );
            newWord.createdAt = DateTime.now();

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
      } catch (e) {
        Get.snackbar(
          '성공',
          '$savedWordNumber개의 단어가 저장되었습니다. ($alreadySaveWordNumber개의 단어가 이미 저장되어 있습니다.)',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white.withOpacity(0.5),
          duration: const Duration(seconds: 1),
          animationDuration: const Duration(seconds: 1),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AdController adController = Get.find<AdController>();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 0),
            child: HomeNaviatorButton(
              text: '나만의 단어 보기',
              onTap: () => Get.toNamed(MY_VOCA_PATH),
            ),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton(
              text: 'Excel로 단어 저장하기',
              onTap: () async {
                bool? result = await Get.dialog<bool>(
                  AlertDialog(
                    title: const Text('Excel 데이터 형식'),
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ExcelInfoText(
                          number: '1. ',
                          text1: '첫번째 열',
                          text2: '일본어',
                        ),
                        ExcelInfoText(
                          number: '2. ',
                          text1: '두번째 열',
                          text2: '읽는 법',
                        ),
                        ExcelInfoText(
                          number: '3. ',
                          text1: '세번째 열',
                          text2: '뜻',
                        ),
                        Text.rich(
                          TextSpan(
                            text: '4. ',
                            children: [
                              TextSpan(
                                  text: '빈 행',
                                  style: TextStyle(color: Colors.red)),
                              TextSpan(text: '이 '),
                              TextSpan(
                                  text: '없도록',
                                  style: TextStyle(color: Colors.red)),
                              TextSpan(text: ' 입력 해 주세요.'),
                            ],
                          ),
                        )
                      ],
                    ),
                    actions: [
                      if (GetPlatform.isWeb)
                        TextButton(
                            onPressed: downloadExcelData,
                            child: const Text(
                              'Excel 샘플 파일 다운로드',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      TextButton(
                          onPressed: () {
                            Get.back(result: true);
                          },
                          child: const Text(
                            '파일 첨부하기',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                );
                if (result != null) {
                  // adController.showIntersistialAd();
                  await postExcelData();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void downloadExcelData() async {
    List<String> dataList = ['일본어', '읽는 법', '뜻'];

    var excel = Excel.createExcel();

    Sheet sheetObject = excel['Sheet1'];

    sheetObject.insertRowIterables(dataList, 0);

    excel.rename('Sheet1', 'jonggack');
    excel.save(fileName: 'jonggack_app.xlsx');
  }
}

class ExcelInfoText extends StatelessWidget {
  const ExcelInfoText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.number});

  final String number;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: number,
        children: [
          TextSpan(text: text1, style: const TextStyle(color: Colors.red)),
          const TextSpan(text: '에 '),
          TextSpan(text: text2, style: const TextStyle(color: Colors.red)),
          const TextSpan(text: '를 입력 해 주세요.'),
        ],
      ),
    );
  }
}
