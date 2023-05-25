import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/tts_controller.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';

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
  bool isSpeakPlaying = false;
  List<Word> words = [];

  bool isAutoPlay = false;

  int _currentPage = 0;
  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    jlptWordController = Get.find<JlptWordController>();

    ttsController = TtsController();

    for (int i = 0; i < jlptWordController.jlptSteps.length; i++) {
      words.addAll(jlptWordController.jlptSteps[i].words);
    }
  }

  void stopListenWords() {
    ttsController.stopListening();
  }

  void startListenWords() async {
    for (int i = _currentPage; i < words.length; i++) {
      if (!isAutoPlay) break;

      await ttsController.systemSpeak(words[_currentPage]);
      await Future.delayed(const Duration(seconds: 1));

      if (_currentPage < words.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (pageController.hasClients) {
        pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    }
  }

  void onPageChange(int value) {
    _currentPage = value;
    setState(() {});
  }

  goToNextPage() async {
    if (_currentPage < words.length - 1) {
      _currentPage++;
      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      //   await manualPlaySound();
    } else {
      return;
    }
  }

  goToPreviousPage() async {
    if (_currentPage > 0) {
      _currentPage--;
      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      // await manualPlaySound();
    } else {
      return;
    }
  }

  manualPlaySound() async {
    isSpeakPlaying = true;
    setState(() {});
    // await ttsController.systemSpeak(
    //     words[_currentPage].yomikata, words[_currentPage].mean);
    await ttsController.systemSpeak(words[_currentPage]);

    isSpeakPlaying = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text(
            '${(_currentPage + 1).toString()} / ${words.length}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: isSelected ? null : Colors.black.withOpacity(0.8),
        body: isSelected
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          isAutoPlay = !isAutoPlay;
                          if (isAutoPlay) {
                            startListenWords();
                          } else {
                            stopListenWords();
                          }
                          setState(() {});
                        },
                        child: isAutoPlay ? const Text('수동') : const Text('자동'),
                      ),
                    ),
                  ),
                  const Spacer(),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed:
                              isSpeakPlaying || isAutoPlay || _currentPage == 0
                                  ? null
                                  : () => goToPreviousPage(),
                          child: const Text('<')),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: isSpeakPlaying || isAutoPlay
                              ? null
                              : () => manualPlaySound(),
                          child: Text('듣기')),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: isSpeakPlaying ||
                                  isAutoPlay ||
                                  _currentPage == words.length - 1
                              ? null
                              : () => goToNextPage(),
                          child: const Text('>')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Spacer()
                ],
              )
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

// import 'package:flutter/material.dart';

// const LISTEN_SCREEN_PATH = '/listen';

// class ListenScreen extends StatefulWidget {
//   const ListenScreen({super.key});

//   @override
//   State<ListenScreen> createState() => _ListenScreenState();
// }

// class _ListenScreenState extends State<ListenScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
