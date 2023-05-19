import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/background.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/controller/tts_controller.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/model/word_step.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_word_controller.dart';

const LISTEN_SCREEN_PATH = '/listen';

class ListenScreen extends StatefulWidget {
  const ListenScreen({super.key});

  @override
  State<ListenScreen> createState() => _ListenScreenState();
}

class _ListenScreenState extends State<ListenScreen> {
  bool isSelected = true;
  late JlptWordController jlptWordController;
  late PageController pageController;
  late TtsController ttsController;
  late Timer _timer;
  List<Word> words = [];

  int _currentPage = 0;
  @override
  void initState() {
    super.initState();

    pageController = PageController();
    jlptWordController = Get.find<JlptWordController>();
    // jlptWordController.setJlptSteps('챕터1');

    ttsController = TtsController();

    for (int i = 0; i < jlptWordController.jlptSteps.length; i++) {
      words.addAll(jlptWordController.jlptSteps[i].words);
    }
    print('words: ${words.length}');

    ttsController.speak(words[_currentPage].word, words[_currentPage].mean);
    setTimer();
  }

  Duration duration = Duration(seconds: 5);

  void setTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      if (_currentPage < words.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      await ttsController.speak(
          words[_currentPage].word, words[_currentPage].mean);
      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void onPageChange(int value) {
    _currentPage = value;
    setState(() {});
  }

  goToNextPage() {
    if (_currentPage < words.length - 1) {
      pageController.nextPage(
          duration: const Duration(seconds: 2), curve: Curves.ease);
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(
          color: Colors.white,
        )),
        backgroundColor: isSelected ? null : Colors.black.withOpacity(0.8),
        body: isSelected
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${(_currentPage + 1).toString()} / ${words.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: onPageChange,
                    itemCount: words.length,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(words[index].yomikata,
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          Text(
                            words[index].word,
                            style:
                                Theme.of(context).textTheme.headline3?.copyWith(
                                      fontSize: 60,
                                      color: Colors.white,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(words[index].mean,
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white))
                        ],
                      );
                    },
                  ),
                ),
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        height: size.height * 0.6,
                        width: size.width * 0.6,
                        color: Colors.red,
                        child: TextFormField()),
                  )
                ],
              ));
  }
}
