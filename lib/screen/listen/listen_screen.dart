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
    jlptWordController = Get.put(JlptWordController(level: '1'));
    jlptWordController.setJlptSteps('챕터1');

    ttsController = TtsController();

    words = jlptWordController.jlptSteps[0].words;
    ttsController.speak(words[_currentPage].word, words[_currentPage].mean);
    setTimer();
  }

  Duration duration = Duration(seconds: 5);

  void setTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      if (_currentPage < words.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _timer.cancel();

      print('1');
      await ttsController.speak(
          words[_currentPage].word, words[_currentPage].mean);
      print('6');
      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
      print('7');
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
      print('END');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: isSelected ? null : Colors.black.withOpacity(0.8),
        body: isSelected
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: onPageChange,
                    itemCount: words.length,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            words[index].word,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            words[index].mean,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      goToNextPage();
                      print('1');

                      print('@');
                    },
                    child: const Text('Click'))
              ])
            //  Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [

            //       ElevatedButton(
            //           onPressed: () async {
            //             print('1');

            //             await ttsController.speak('午後', '오전');

            //             print('@');
            //           },
            //           child: const Text('Click'))
            //     ],
            //   )
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
