import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';

class HomeMyVocaSceen extends StatelessWidget {
  const HomeMyVocaSceen({super.key});

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

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    AdController adController = Get.find<AdController>();

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 0),
            child: HomeNaviatorButton2(
              text: '나만의 단어 보기',
              onTap: () {
                if (random.nextBool()) {
                  adController.showIntersistialAd();
                }

                Get.toNamed(MY_VOCA_PATH);
              },
            ),
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 300),
            child: HomeNaviatorButton2(
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
                  // AD
                  adController.showIntersistialAd();
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
        style: const TextStyle(color: AppColors.scaffoldBackground),
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

class HomeNaviatorButton2 extends StatelessWidget {
  const HomeNaviatorButton2({
    Key? key,
    required this.text,
    this.onTap,
    this.wordsCount,
    this.jlptN1Key,
  }) : super(key: key);

  final GlobalKey? jlptN1Key;
  final String text;
  final String? wordsCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: SizedBox(
        width: size.width * 0.7,
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key: jlptN1Key,
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
              ),
              if (wordsCount != null)
                Text(
                  '$wordsCount개',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
            ],
          ),
        ),
      ),
      // child: InkWell(
      //   onTap: onTap,
      //   child: Container(
      //       height: 50,
      //       width: size.width * 0.7,
      //       decoration: const BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(5),
      //           ),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               offset: Offset(1, 1),
      //             ),
      //           ]),
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               key: jlptN1Key,
      //               text,
      //               style: Theme.of(context).textTheme.labelLarge!.copyWith(
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //             ),
      //             if (wordsCount != null)
      //               Text(
      //                 '$wordsCount개',
      //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
      //                       color: Colors.black,
      //                     ),
      //               ),
      //           ],
      //         ),
      //       )),
      // ),
    );
  }
}
