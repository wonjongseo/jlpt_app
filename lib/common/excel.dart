import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../model/my_word.dart';
import '../repository/my_word_repository.dart';

void downloadExcelData() async {
  List<String> dataList = ['일본어', '읽는 법', '뜻'];

  var excel = Excel.createExcel();

  Sheet sheetObject = excel['Sheet1'];

  sheetObject.insertRowIterables(dataList, 0);

  excel.rename('Sheet1', 'jonggack');
  excel.save(fileName: 'jonggack_app.xlsx');
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
