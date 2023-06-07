import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';
import 'package:japanese_voca/screen/my_voca/home_my_voca_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/screen/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/user_controller2.dart';
import 'package:table_calendar/table_calendar.dart';

import 'ad_controller.dart';
import 'components/level_select_button.dart';
import 'components/part_of_information.dart';
import 'config/colors.dart';
import 'model/my_word.dart';

String HOME_PATH2 = '/home2';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

List<String> jlptLevels = ['N1', 'N2', 'N3', 'N4', 'N5'];

class _HomeScreen2State extends State<HomeScreen2> {
  late PageController pageController;
  AdController adController = Get.find<AdController>();

  late int currentPageIndex;
  @override
  void initState() {
    super.initState();

    currentPageIndex = LocalReposotiry.getUserJlptLevel();
    pageController = PageController(initialPage: currentPageIndex);
  }

  void pageChange(int page) async {
    currentPageIndex = page;

    pageController.jumpToPage(currentPageIndex);
    setState(() {});
    await LocalReposotiry.updateUserJlptLevel(page);
  }

  MyVocaController myVocaController = Get.put(MyVocaController());

  void goToJlptStudy(String index) {
    Get.to(
      () => JlptBookStepScreen(
        level: index,
        isJlpt: true,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  void goToKangiScreen(String level) {
    Get.to(
      () => JlptBookStepScreen(
        level: level,
        isJlpt: false,
      ),
      transition: Transition.leftToRight,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WelcomeWidget(),
          LevelSelectButton(
            currentPageIndex: currentPageIndex,
            pageChange: pageChange,
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: pageController,
              itemBuilder: (context, index) {
                const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
                return GetBuilder<UserController2>(builder: (userController2) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        PartOfInformation(
                          goToSutdy: () {
                            goToJlptStudy((index + 1).toString());
                          },
                          text: 'JLPT 단어',
                          currentProgressCount:
                              userController2.user.currentJlptWordScroes[index],
                          totalProgressCount:
                              userController2.user.jlptWordScroes[index],
                          edgeInsets: edgeInsets,
                        ),
                        if (index < 3)
                          PartOfInformation(
                            goToSutdy: () {
                              Get.to(() => GrammarStepSceen(
                                  level: (index + 1).toString()));
                            },
                            text: 'JLPT 문법',
                            currentProgressCount: userController2
                                .user.currentGrammarScores[index],
                            totalProgressCount:
                                userController2.user.grammarScores[index],
                            edgeInsets: edgeInsets,
                          ),
                        PartOfInformation(
                          goToSutdy: () {
                            goToKangiScreen((index + 1).toString());
                          },
                          text: 'JLPT 한자',
                          currentProgressCount:
                              userController2.user.currentKangiScores[index],
                          totalProgressCount:
                              userController2.user.kangiScores[index],
                          edgeInsets: edgeInsets,
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(MY_VOCA_PATH);
                          },
                          child: Text(
                            '나만의 단어장',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            bool? result = await Get.dialog<bool>(
                              AlertDialog(
                                title: const Text(
                                  'Excel 데이터 형식',
                                  style: TextStyle(
                                      color: AppColors.scaffoldBackground),
                                ),
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
                                      style: TextStyle(
                                          color: AppColors.scaffoldBackground),
                                      TextSpan(
                                        text: '4. ',
                                        children: [
                                          TextSpan(
                                              text: '빈 행',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          TextSpan(text: '이 '),
                                          TextSpan(
                                              text: '없도록',
                                              style:
                                                  TextStyle(color: Colors.red)),
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  TextButton(
                                      onPressed: () {
                                        Get.back(result: true);
                                      },
                                      child: const Text(
                                        '파일 첨부하기',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            );
                            if (result != null) {
                              // AD
                              adController.showIntersistialAd();
                              await postExcelData();
                            }
                          },
                          child: Text(
                            'Excel단어 저장',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> postExcelData() async {
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
}
