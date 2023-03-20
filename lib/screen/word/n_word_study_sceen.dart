import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

class NWordStudyScreen extends StatefulWidget {
  const NWordStudyScreen(
      {super.key, required this.words, required this.hiveKey});

  final String hiveKey;
  final List<Word> words;

  @override
  State<NWordStudyScreen> createState() => _NWordStudyScreenState();
}

class _NWordStudyScreenState extends State<NWordStudyScreen> {
  int currentIndex = 0;
  int correctCount = 0;
  //  correctCount = 0;
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
        final altResut = await Get.dialog(
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
        if (altResut) {
          unKnownWords.shuffle();
          Get.back();
          Get.to(() => NWordStudyScreen(
                words: unKnownWords,
                hiveKey: widget.hiveKey,
              ));
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
        leading: IconButton(
          onPressed: () async {
            if (currentIndex != 0) {
              LocalReposotiry.updateCheckStep(widget.hiveKey, correctCount);
              // final altResut = await Get.dialog(
              //   barrierDismissible: false,
              //   AlertDialog(
              //     title: const Text('중도에 나가시면 점수가 소멸됩니다.'),
              //     content: const Text('나가시겠습니까?'),
              //     actions: [
              //       ElevatedButton(
              //         onPressed: () {
              //           Get.back(result: true);
              //         },
              //         child: const Text('Yes'),
              //       ),
              //       ElevatedButton(
              //         onPressed: () {
              //           Get.back(result: false);
              //         },
              //         child: const Text('No'),
              //       )
              //     ],
              //   ),
              // );
              //  if (altResut) {
              //   Get.back();
              //   Get.back();
              // }
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
                child: Text(
                  widget.words[currentIndex].word,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
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
