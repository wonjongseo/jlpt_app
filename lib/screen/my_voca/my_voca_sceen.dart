import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/screen/my_voca/services/my_word_tutorial_service.dart';

import 'components/flip_button.dart';
import 'components/my_word_input_field.dart';

class MyVocaPage extends StatefulWidget {
  const MyVocaPage({super.key});

  @override
  State<MyVocaPage> createState() => _MyVocaPageState();
}

class _MyVocaPageState extends State<MyVocaPage> {
  List<MyWord> myWords = [];

  bool isTextFieldOpen = true;
  bool isOnlyKnown = false;
  bool isOnlyUnKnown = false;
  bool isWordFlip = false;

  late bool isSeenTutorial;
  MyWordRepository myWordReposotiry = MyWordRepository();

  late TextEditingController wordController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;
  late MyVocaTutorialService? myVocaTutorialService = null;
  late FocusNode wordFocusNode;
  late FocusNode yomikataFocusNode;
  late FocusNode meanFocusNode;

  void loadData() async {
    myWords = await myWordReposotiry.getAllMyWord();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isSeenTutorial = LocalReposotiry.isSeenMyWordTutorial();
    if (!isSeenTutorial) {
      MyWord tempWord = MyWord(word: '食べる', mean: '먹다', yomikata: 'たべる');
      tempWord.isKnown = true;
      DateTime now = DateTime.now();
      String nowString = now.toString();
      String formattedNow = nowString.substring(0, 16);
      tempWord.createdAt = formattedNow;

      myWords.add(tempWord);
      setState(() {});
      myVocaTutorialService = MyVocaTutorialService();
      myVocaTutorialService!.initTutorial();
      myVocaTutorialService!.showTutorial(context, () {
        myWords.remove(tempWord);
        setState(() {});
      });
    } else {
      loadData();
    }

    wordController = TextEditingController();
    yomikataController = TextEditingController();
    meanController = TextEditingController();
    wordFocusNode = FocusNode();
    yomikataFocusNode = FocusNode();
    meanFocusNode = FocusNode();
  }

  @override
  void dispose() {
    wordController.dispose();
    yomikataController.dispose();
    meanController.dispose();
    wordFocusNode.dispose();
    yomikataFocusNode.dispose();
    meanFocusNode.dispose();
    super.dispose();
  }

  void saveWord() async {
    String word = wordController.text;
    String yomikata = yomikataController.text;
    String mean = meanController.text;

    if (word.isEmpty) {
      wordFocusNode.requestFocus();
      return;
    }
    if (yomikata.isEmpty) {
      yomikataFocusNode.requestFocus();
      return;
    }
    if (mean.isEmpty) {
      meanFocusNode.requestFocus();
      return;
    }

    MyWord newWord = MyWord(word: word, mean: mean, yomikata: yomikata);

    DateTime now = DateTime.now();
    String nowString = now.toString();
    String formattedNow = nowString.substring(0, 16);
    newWord.createdAt = formattedNow;

    myWords.add(newWord);
    MyWordRepository.saveMyWord(newWord);

    wordController.clear();
    meanController.clear();
    yomikataController.clear();
    wordFocusNode.requestFocus();

    setState(() {});
  }

  void deleteWord(int index) {
    myWordReposotiry.deleteMyWord(myWords[index]);
    myWords.removeAt(index);
  }

  void updateWord(int index) {
    myWordReposotiry.updateKnownMyVoca(myWords[index]);
  }

  void changeFunc() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(
                    text: '암기 단어',
                    onTap: () {
                      isOnlyKnown = true;
                      isOnlyUnKnown = false;
                      setState(() {});
                      Navigator.pop(context);
                    }),
                const SizedBox(width: 10),
                FlipButton(
                    text: '미암기 단어',
                    onTap: () {
                      isOnlyUnKnown = true;
                      isOnlyKnown = false;
                      setState(() {});
                      Navigator.pop(context);
                    }),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(
                    text: '모든 단어',
                    onTap: () {
                      isOnlyKnown = false;
                      isOnlyUnKnown = false;
                      setState(() {});
                      Navigator.pop(context);
                    }),
                const SizedBox(width: 10),
                FlipButton(
                    text: '뒤집기',
                    onTap: () {
                      isWordFlip = !isWordFlip;
                      setState(() {});
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double responsiveWordBoxHeight = size.width > 700 ? 130 : 55;
    double responsiveTextFontSize = size.width > 700 ? 25 : 18;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: TextButton(
          child: Text(
            key: myVocaTutorialService?.inputFormCloseKey,
            isTextFieldOpen ? '입력 상자 닫기' : '입력 상자 열기',
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            isTextFieldOpen = !isTextFieldOpen;
            setState(() {});
          },
        ),
        actions: [
          IconButton(
              onPressed: changeFunc,
              icon: Icon(Icons.flip, key: myVocaTutorialService?.flipKey))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Visibility(
              visible: isTextFieldOpen,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MyWordInputField(
                  key: myVocaTutorialService?.inputFormKey,
                  saveWord: saveWord,
                  wordFocusNode: wordFocusNode,
                  wordController: wordController,
                  yomikataFocusNode: yomikataFocusNode,
                  yomikataController: yomikataController,
                  meanFocusNode: meanFocusNode,
                  meanController: meanController,
                ),
              ),
            ),
            Visibility(
              visible: isTextFieldOpen,
              child: const Divider(height: 40),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    myWords.length,
                    (index) {
                      if (isOnlyKnown) {
                        if (myWords[myWords.length - 1 - index].isKnown ==
                            false) {
                          return const SizedBox();
                        }
                      } else if (isOnlyUnKnown) {
                        if (myWords[myWords.length - 1 - index].isKnown ==
                            true) {
                          return const SizedBox();
                        }
                      }
                      return Padding(
                        key: index == 0
                            ? myVocaTutorialService?.myVocaTouchKey
                            : null,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  updateWord(myWords.length - index - 1);
                                  setState(() {});
                                },
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                icon: Icons.check,
                                label: myWords[myWords.length - 1 - index]
                                            .isKnown ==
                                        true
                                    ? '미암기'
                                    : '암기',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  deleteWord(myWords.length - index - 1);
                                  setState(() {});
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: '삭제',
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  myWords[myWords.length - 1 - index].isKnown
                                      ? AppColors.correctColor
                                      : AppColors.whiteGrey,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                            ),
                            onPressed: () {
                              DateTime now = DateTime.now();
                              print('now: ${now}');
                              print('2023-05-26 15:28'.length);

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: KangiText(
                                      fontSize: 40,
                                      color: Colors.black,
                                      japanese:
                                          myWords[myWords.length - 1 - index]
                                              .word,
                                      clickTwice: false,
                                    ),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '의미 : ${myWords[myWords.length - 1 - index].mean}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '읽는 법 : ${myWords[myWords.length - 1 - index].yomikata}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: responsiveWordBoxHeight,
                                  child: Center(
                                      child: Text(
                                    isWordFlip
                                        ? myWords[myWords.length - 1 - index]
                                            .mean
                                        : myWords[myWords.length - 1 - index]
                                            .word,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsiveTextFontSize,
                                    ),
                                  )),
                                ),
                                if (myWords[myWords.length - 1 - index]
                                        .createdAt !=
                                    null)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      '${myWords[myWords.length - 1 - index].createdAt!}에 저장됨',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
