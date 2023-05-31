import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isAutoSave = LocalReposotiry.getAutoSave();
  bool isQuesetionMark = LocalReposotiry.getquestionMark();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '모름 / 틀림 단어 자동 저장',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  value: isAutoSave,
                  onChanged: (value) {
                    isAutoSave = LocalReposotiry.autoSaveOnOff();
                    Get.closeAllSnackbars();

                    setState(() {});
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '의미 / 읽는법 글자수 표시',
                  style: TextStyle(color: Colors.white),
                ),
                Switch(
                  value: isQuesetionMark,
                  onChanged: (value) {
                    isQuesetionMark = LocalReposotiry.questionMarkOnOff();
                    Get.closeAllSnackbars();

                    setState(() {});
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('Jlpt 단어를 초기화 하시겠습니까 ?'),
                    content: const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));
                if (result) {
                  JlptStepRepositroy.deleteAllWord();
                  Get.closeAllSnackbars();
                  Get.snackbar(
                    '초기화 완료!',
                    '새로고침을 해주세요.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    duration: const Duration(seconds: 2),
                    animationDuration: const Duration(seconds: 2),
                  );
                }
              },
              child: const SettingButton(
                text: 'Jlpt 초기화 (단어 섞기)',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('문법을 초기화 하시겠습니까 ?'),
                    content: const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));

                if (result) {
                  GrammarRepositroy.deleteAllGrammar();
                  Get.closeAllSnackbars();
                  Get.snackbar(
                    '초기화 완료!',
                    '새로고침을 해주세요.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.white.withOpacity(0.5),
                    animationDuration: const Duration(seconds: 2),
                  );
                }
              },
              child: const SettingButton(
                text: '문법 초기화 (문법 섞기)',
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('한자을 초기화 하시겠습니까 ?'),
                    content: const Text(''));

                if (result) {
                  KangiStepRepositroy.deleteAllKangiStep();
                  Get.closeAllSnackbars();
                  Get.snackbar(
                    '초기화 완료!',
                    '새로고침을 해주세요.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.white.withOpacity(0.5),
                    animationDuration: const Duration(seconds: 2),
                  );
                }
              },
              child: const SettingButton(
                text: '한자 초기화 (한자 섞기)',
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () async {
                bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('나만의 단어를 초기화 하시겠습니까 ?'),
                    content: const Text('되돌릴 수 없습니다, 그래도 진행하시겠습니까?'));

                if (result) {
                  MyWordRepository.deleteAllMyWord();

                  Get.closeAllSnackbars();
                  Get.snackbar(
                    '초기화 완료!',
                    '새로고침을 해주세요.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.white.withOpacity(0.5),
                    animationDuration: const Duration(seconds: 2),
                  );
                }
              },
              child: const SettingButton(
                text: '나만의 단어 초기화',
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.5),
          ]),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
