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
  const HomeScreen({super.key});

  void goTo(String index) {
    Get.to(() => JlptScreen(level: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('종각 JLPT'),
        actions: [
          TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse('mailto:visionwill3322@gmail.com'),
                );
              },
              child: const Text(
                '버그신고',
              ))
        ],
      ),
      drawer: _drawer(),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPageButton(onTap: () => goTo('1'), level: 'N1'),
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
