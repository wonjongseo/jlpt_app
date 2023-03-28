import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';

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
  bool isAgainTest = false;
  List<Word> unKnownWords = [];
  List<Word> words = [];
  bool isShowQustionmar = true;

  String transparentMean = '';
  String transparentYomikata = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _questionController = Get.put(QuestionController());
    isShowQustionmar = LocalReposotiry.getquestionMark();
    if (Get.arguments != null && Get.arguments['againTest'] != null) {
      isAgainTest = true;
    }
    jlptStep = jlptWordController.getJlptStep();

    if (jlptStep.unKnownWord.isNotEmpty) {
      words = jlptStep.unKnownWord;
    } else {
      words = jlptStep.words;
    }
    if (isShowQustionmar) {
      transparentMean = createTransparentText(words[currentIndex].mean);
      transparentYomikata = createTransparentText(words[currentIndex].yomikata);
    }
  }

  String createTransparentText(String word) {
    String transparentText = '';
    for (int i = 0; i < word.length; i++) {
      if (word[i] == ' ') {
        transparentText += ' ';
      } else if (word[i] == ',') {
        transparentText += ',';
      } else {
        transparentText += '?';
      }
    }
    return transparentText;
  }

  bool isShownMean = false;
  bool isShownYomikata = false;

  void nextWord(bool isKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    if (isKnwon == false) {
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);
      MyWord.saveMyVoca(currentWord);
    } else {
      correctCount++;
    }
    currentIndex++;

    if (currentIndex >= words.length) {
      //테스트 2번째
      if (isAgainTest) {
        final alertResult = await getAlertDialog(
            Text('${unKnownWords.length}가 남아 있습니다.'),
            const Text('테스트 페이지로 넘어가시겠습니까?'),
            barrierDismissible: true);
        if (alertResult != null) {
          if (alertResult!) {
            Get.closeAllSnackbars();
            jlptWordController.updateScore(correctCount);
            goToTest();
          } else {
            jlptWordController.updateScore(correctCount);
            Get.back();
          }
        } else {
          jlptWordController.updateScore(correctCount);
          Get.back();
        }

        return;
      }
      if (unKnownWords.isNotEmpty) {
        final alertResult = await getAlertDialog(
          Text('${unKnownWords.length}가 남아 있습니다.'),
          const Text('모르는 단어를 다시 보시겠습니까?'),
        );

        if (alertResult!) {
          Get.closeAllSnackbars();
          unKnownWords.shuffle();
          jlptStep.unKnownWord = unKnownWords;
          jlptWordController.updateScore(correctCount);
          Get.offNamed(N_WORD_STUDY_PATH,
              arguments: {'againTest': true}, preventDuplicates: false);
        } else {
          Get.closeAllSnackbars();
          jlptStep.unKnownWord = [];
          jlptWordController.updateScore(correctCount);
          Get.back();
        }

        return;
      } else {
        // 모르는 단어가 없는 경우
        jlptStep.unKnownWord = [];
        jlptWordController.updateScore(correctCount, isAgain: true);
        Get.back();
        return;
      }
    } else {}
    if (isShowQustionmar) {
      transparentMean = createTransparentText(words[currentIndex].mean);
      transparentYomikata = createTransparentText(words[currentIndex].yomikata);
    }

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
              // child: Text(
              //   words[currentIndex].yomikata,
              //   style: Theme.of(context).textTheme.headline6?.copyWith(
              //         color:
              //             isShownYomikata ? Colors.black : Colors.transparent,
              //       ),
              // ),
              child: isShowQustionmar
                  ? Text(
                      !isShownYomikata
                          ? transparentYomikata
                          : words[currentIndex].yomikata,
                    )
                  : Text(
                      words[currentIndex].yomikata,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: isShownYomikata
                                ? Colors.black
                                : Colors.transparent,
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
                  words[currentIndex].word,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // SizedBox(
            // child: Text(
            //   words[currentIndex].mean,
            //   style: Theme.of(context).textTheme.headline6?.copyWith(
            //       color: isShownMean ? Colors.black : Colors.transparent),
            // ),
            // ),
            SizedBox(
              child: isShowQustionmar
                  ? Text(
                      !isShownMean ? transparentMean : words[currentIndex].mean,
                    )
                  : Text(
                      words[currentIndex].mean,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color:
                              isShownMean ? Colors.black : Colors.transparent),
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
            onPressed: goToTest,
            child: const Text('TEST'),
          ),
        const SizedBox(width: 15),
        IconButton(
            onPressed: () {
              Word currentWord = words[currentIndex];

              MyWord.saveMyVoca(currentWord, isManualSave: true);
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

  void goToTest() async {
    bool? alertResult = await getTransparentAlertDialog(
      contentChildren: [
        CustomButton(text: '뜻', onTap: () => Get.back(result: true)),
        CustomButton(text: '읽는 법', onTap: () => Get.back(result: false)),
      ],
    );

    if (alertResult != null) {
      // _questionController.startQuiz(jlptStep.words, alertResult);
      Get.toNamed(QUIZ_PATH,
          arguments: {'words': jlptStep.words, 'alertResult': alertResult});
    }
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
