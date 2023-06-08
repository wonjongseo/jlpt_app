import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_book_step/jlpt_book_step_screen.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/screen/my_voca/services/my_voca_controller.dart';

import 'package:japanese_voca/user_controller2.dart';

import 'ad_controller.dart';
import 'components/level_select_button.dart';
import 'components/part_of_information.dart';
import 'config/colors.dart';
import 'model/my_word.dart';

const String HOME_PATH2 = '/home2';

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
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: WelcomeWidget(),
            ),
            Expanded(
              flex: 5,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                controller: pageController,
                itemBuilder: (context, index) {
                  const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
                  return GetBuilder<UserController2>(
                      builder: (userController2) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PartOfInformation(
                            goToSutdy: () {
                              goToJlptStudy((index + 1).toString());
                            },
                            text: 'JLPT 단어',
                            currentProgressCount: userController2
                                .user.currentJlptWordScroes[index],
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
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeInLeft(
                          child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextButton(
                              onPressed: () => Get.toNamed(MY_VOCA_PATH),
                              child: const Text(
                                '나만의 단어장',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeInLeft(
                          child: SizedBox(
                            height: 45,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Excel 단어 저장하기',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: pageChange,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPageIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey),
                  child: const Text(
                    'N1',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                    ),
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPageIndex == 1
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey),
                  child: const Text(
                    'N2',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                    ),
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPageIndex == 2
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey),
                  child: const Text(
                    'N3',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                    ),
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPageIndex == 3
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey),
                  child: const Text(
                    'N4',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                    ),
                  )),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPageIndex == 4
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey),
                  child: const Text(
                    'N5',
                    style: TextStyle(
                      color: AppColors.scaffoldBackground,
                    ),
                  )),
              label: ''),
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
