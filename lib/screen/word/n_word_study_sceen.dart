import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';
import 'package:japanese_voca/screen/word/n_word_screen.dart';
import 'package:japanese_voca/screen/word/word_sceen.dart';

final String N_WORD_STUDY_PATH = '/n_word_study';

class NWordStudyScreen extends StatefulWidget {
  const NWordStudyScreen({super.key});

  @override
  State<NWordStudyScreen> createState() => _NWordStudyScreenState();
}

class _NWordStudyScreenState extends State<NWordStudyScreen> {
  // late QuestionController _questionController;
  JlptWordController jlptWordController = Get.find<JlptWordController>();

  late JlptStep jlptStep;
  int currentIndex = 0;
  int correctCount = 0;

  List<Word> unKnownWords = [];
  List<Word> words = [];

  @override
  void initState() {
    super.initState();
    // _questionController = Get.put(QuestionController());
    jlptStep = jlptWordController.getJlptStep();
    if (jlptStep.unKnownWord.isNotEmpty) {
      words = jlptStep.unKnownWord;
    } else {
      words = jlptStep.words;
    }
  }

  bool isShownMean = false;
  bool isShownYomikata = false;

  void saveMyVoca(Word word) {
    MyWord newMyWord =
        MyWord(word: word.word, mean: '${word.mean}\n${word.yomikata}');
    LocalReposotiry.saveMyWord(newMyWord);
  }

  void nextWord(bool isKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    if (isKnwon == false) {
      // 모르는 단어.
      unKnownWords.add(currentWord);
      // jlptStep.unKnownWord.add(currentWord);
      saveMyVoca(currentWord);
    } else {
      correctCount++;
    }
    currentIndex++;

    if (currentIndex >= words.length) {
      if (unKnownWords.isNotEmpty) {
        final alertResult = await getAlertDialog(
          Text('${unKnownWords.length}가 남아 있습니다.'),
          const Text('틀린 문제를 다시 보시겠습니까?'),
        );

        if (alertResult!) {
          unKnownWords.shuffle();
          jlptStep.unKnownWord = unKnownWords;
          jlptWordController.updateScore(correctCount);
          Get.offNamed(N_WORD_STUDY_PATH, preventDuplicates: false);
        } else {
          jlptStep.unKnownWord = [];
          Get.back();
        }

        return;
      } else {
        // 모르는 단어가 없는 경우
        jlptWordController.updateScore(correctCount, isAgain: true);
        Get.back();
        return;
      }
    } else {}
    setState(() {});
  }

  void copyWord() {
    Clipboard.setData(ClipboardData(text: words[currentIndex].word));

    if (!Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      Get.snackbar(
        'Copied',
        '${words[currentIndex].word}가 복사(Ctrl + C) 되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        animationDuration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              child: Text(
                jlptStep.words[currentIndex].yomikata,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color:
                          isShownYomikata ? Colors.black : Colors.transparent,
                    ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: copyWord,
                child: Text(
                  jlptStep.words[currentIndex].word,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              child: Text(
                jlptStep.words[currentIndex].mean,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: isShownMean ? Colors.black : Colors.transparent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: '의미',
              onTap: () {
                isShownMean = !isShownMean;
                setState(() {});
              },
            ),
            const SizedBox(width: 16),
            CustomButton(
              text: '읽는 법',
              onTap: () {
                isShownYomikata = !isShownYomikata;
                setState(() {});
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: '몰라요',
              onTap: () {
                nextWord(false);
              },
            ),
            const SizedBox(width: 16),
            CustomButton(
              text: '알아요',
              onTap: () {
                nextWord(true);
              },
            ),
          ],
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      actions: [
        if (words.length >= 4)
          TextButton(
            onPressed: () async {
              bool? alertResult = await getTransparentAlertDialog(
                contentChildren: [
                  CustomButton(text: '뜻', onTap: () => Get.back(result: true)),
                  CustomButton(
                      text: '읽는 법', onTap: () => Get.back(result: false)),
                ],
              );

              if (alertResult != null) {
                // _questionController.startQuiz(jlptStep.words, alertResult);
                Get.toNamed(QUIZ_PATH, arguments: {
                  'words': jlptStep.words,
                  'alertResult': alertResult
                });
              }
            },
            child: const Text('TEST'),
          ),
        const SizedBox(width: 15),
        IconButton(
            onPressed: () {
              Word currentWord = words[currentIndex];

              saveMyVoca(currentWord);

              if (!Get.isSnackbarOpen) {
                Get.snackbar(
                  '${currentWord.word} 저장되었습니다.',
                  '단어장에서 확인하실 수 있습니다.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  animationDuration: const Duration(seconds: 2),
                );
              }
            },
            icon: SvgPicture.asset('assets/svg/save.svg')),
        const SizedBox(width: 15),
      ],
      leading: IconButton(
        onPressed: () async {
          jlptStep.unKnownWord = [];
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: Text('${currentIndex + 1} / ${words.length}'),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.5),
            ]),
        child: Center(child: Text(text)),
      ),
    );
  }
}
