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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SettingSwitch(
                isOn: isAutoSave,
                onChanged: (value) {
                  isAutoSave = LocalReposotiry.autoSaveOnOff();
                  Get.closeAllSnackbars();
                  setState(() {});
                },
                text: '모름 / 틀림 단어 자동 저장',
              ),
              SettingSwitch(
                isOn: isQuesetionMark,
                onChanged: (value) {
                  isQuesetionMark = LocalReposotiry.questionMarkOnOff();
                  Get.closeAllSnackbars();
                  setState(() {});
                },
                text: '의미 / 읽는법 글자수 표시',
              ),
              SettingButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('Jlpt 단어를 초기화 하시겠습니까 ?'),
                      content: const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));
                  if (result) {
                    JlptStepRepositroy.deleteAllWord();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
                text: 'Jlpt 초기화 (단어 섞기)',
              ),
              SettingButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('문법을 초기화 하시겠습니까 ?'),
                      content: const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));

                  if (result) {
                    GrammarRepositroy.deleteAllGrammar();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
                text: '문법 초기화 (문법 섞기)',
              ),
              SettingButton(
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('한자을 초기화 하시겠습니까 ?'),
                      content: const Text('점수들도 함께 사라집니다. 그래도 진행하시겠습니까?'));

                  if (result) {
                    KangiStepRepositroy.deleteAllKangiStep();
                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
                text: '한자 초기화 (한자 섞기)',
              ),
              SettingButton(
                text: '나만의 단어 초기화',
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('나만의 단어를 초기화 하시겠습니까 ?'),
                      content: const Text('되돌릴 수 없습니다, 그래도 진행하시겠습니까?'));

                  if (result) {
                    MyWordRepository.deleteAllMyWord();

                    Get.closeAllSnackbars();
                    Get.snackbar(
                      '초기화 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
              ),
              const SizedBox(height: 5),
              SettingButton(
                text: '앱 설명 보기',
                onPressed: () async {
                  bool result = await askToWatchMovieAndGetHeart(
                      title: const Text('앱 설명을 다시 보시겠습니까?'),
                      content: const Text(''));

                  if (result) {
                    LocalReposotiry.isSeenGrammarTutorial(isRestart: true);
                    LocalReposotiry.isSeenHomeTutorial(isRestart: true);
                    LocalReposotiry.isSeenMyWordTutorial(isRestart: true);
                    LocalReposotiry.isSeenWordStudyTutorialTutorial(
                        isRestart: true);

                    Get.snackbar(
                      '앱 설명 완료!',
                      '앱을 재시작 해주세요.',
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.white.withOpacity(0.5),
                      animationDuration: const Duration(seconds: 2),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  const SettingSwitch(
      {super.key,
      required this.text,
      required this.isOn,
      required this.onChanged});

  final String text;
  final bool isOn;
  final Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width * 0.8,
      height: size.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Switch(value: isOn, onChanged: onChanged),
        ],
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.08,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
