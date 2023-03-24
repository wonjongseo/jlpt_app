import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/Question.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/quiz/quiz_screen.dart';

class NWordStudyScreen extends StatefulWidget {
  NWordStudyScreen(
      {super.key,
      required this.words,
      required this.hiveKey,
      this.correctCount = 0});

  final String hiveKey;
  final List<Word> words;
  int correctCount;

  @override
  State<NWordStudyScreen> createState() => _NWordStudyScreenState();
}

class _NWordStudyScreenState extends State<NWordStudyScreen> {
  final QuestionController _questionController = Get.put(QuestionController());
  int currentIndex = 0;
  int correctCount = 0;
  int totalCount = 0;
  @override
  void initState() {
    super.initState();
    totalCount = widget.correctCount + widget.words.length;
  }

  bool isShownMean = false;
  bool isShownYomikata = false;

  final List<Word> unKnownWords = [];

  void nextWord(bool isKnwon) async {
    print('widget.hiveKey: ${widget.hiveKey}');

    isShownMean = false;
    isShownYomikata = false;

    if (isKnwon == false) {
      unKnownWords.add(widget.words[currentIndex]);
    } else {
      correctCount++;
    }
    currentIndex++;

    if (currentIndex >= widget.words.length) {
      if (unKnownWords.isNotEmpty) {
        final altResult = await Get.dialog(
          barrierDismissible: false,
          AlertDialog(
            title: Text('${unKnownWords.length}가 남아 있습니다.'),
            content: Text('틀린 문제를 다시 보시겠습니까?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: const Text('No'),
              )
            ],
          ),
        );
        if (altResult) {
          // Again
          LocalReposotiry.updateCheckStep(widget.hiveKey, correctCount);
          unKnownWords.shuffle();
          Get.back();

          Get.to(() => NWordStudyScreen(
              words: unKnownWords,
              hiveKey: widget.hiveKey,
              correctCount: correctCount));
        } else {
          Get.back();
        }

        return;
      } else {
        LocalReposotiry.updateCheckStep(widget.hiveKey, correctCount);
        Get.back();
        Get.back();
        return;
      }
    } else {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () async {
                final result = await Get.dialog(
                  // barrierDismissible: false,
                  AlertDialog(
                    backgroundColor: Colors.transparent,
                    actionsAlignment: MainAxisAlignment.spaceAround,
                    // title: Text('asdasd.'),
                    // content: Text('틀린 문제를 다시 보시겠습니까?'),
                    content: Container(
                      width: 300,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              text: '뜻',
                              onTap: () {
                                Get.back(result: true);
                              }),
                          CustomButton(
                              text: '읽는 법',
                              onTap: () {
                                Get.back(result: false);
                              }),
                        ],
                      ),
                    ),
                  ),
                );
                print('result: ${result}');

                if (result != null) {
                  _questionController.map =
                      Question.generateQustion(widget.words);
                  if (result) {
                    _questionController.setQuestions(true);
                  } else {
                    _questionController.setQuestions(false);
                  }
                  Get.toNamed(QUIZ_PATH);
                }

                // print('why1');
                // _questionController.map =
                //     Question.generateQustion(widget.words);
                // print('why2');
                // _questionController.setQuestions();
                // print('why3');
                // Get.to(() => QuizScreen());
              },
              child: Text('Test')),
          const SizedBox(width: 15),
          TextButton(
            onPressed: () {
              String word = widget.words[currentIndex].word;
              MyWord newMyWord = MyWord(
                  word: word,
                  mean:
                      '${widget.words[currentIndex].mean} / ${widget.words[currentIndex].yomikata}');
              LocalReposotiry.saveMyWord(newMyWord);
              if (!Get.isSnackbarOpen) {
                Get.snackbar(
                  '$word가 저장되었습니다.',
                  '단어장에서 확인하실 수 있습니다.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                  animationDuration: const Duration(seconds: 2),
                );
              }
            },
            child: const Text('단어 저장'),
          )
        ],
        leading: IconButton(
          onPressed: () async {
            if (currentIndex != 0) {
              LocalReposotiry.updateCheckStep(widget.hiveKey, correctCount);

              Get.back();
              Get.back();
            } else {
              Get.back();
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('${currentIndex + 1} / ${widget.words.length}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                child: Text(
                  widget.words[currentIndex].yomikata,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color:
                          isShownYomikata ? Colors.black : Colors.transparent),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: widget.words[currentIndex].word));

                    if (!Get.isSnackbarOpen) {
                      Get.closeAllSnackbars();
                      Get.snackbar(
                        'Copied',
                        '${widget.words[currentIndex].word}가 복사(Ctrl + C) 되었습니다.',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                        animationDuration: const Duration(seconds: 2),
                      );
                    }
                  },
                  child: Text(
                    widget.words[currentIndex].word,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: Text(
                  widget.words[currentIndex].mean,
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
      ),
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
