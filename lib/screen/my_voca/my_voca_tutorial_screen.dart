import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

class MyVocaTutorialPage extends StatefulWidget {
  const MyVocaTutorialPage({super.key});

  @override
  State<MyVocaTutorialPage> createState() => _MyVocaTutorialPageState();
}

class _MyVocaTutorialPageState extends State<MyVocaTutorialPage> {
  List<MyWord> myWords = [];
  List<bool> isKnwonWords = [];
  bool isOnlyKnown = false;
  bool isOnlyUnKnown = false;
  bool isWordFlip = false;
  late TextEditingController wordController;
  late TextEditingController meanController;
  late TextEditingController yomikataController;
  late FocusNode wordFocusNode;
  late FocusNode meanFocusNode;
  late FocusNode yomikataFocusNode;

  void loadData() {
    myWords = [
      MyWord(
        word: '食べる',
        mean: '먹다',
        yomikata: 'たべる',
      ),
      MyWord(word: '行く', mean: '가다', yomikata: 'いく'),
      MyWord(word: '愛する', mean: '사랑하다', yomikata: 'あいする'),
      MyWord(word: '日本語', mean: '일본어', yomikata: 'にほんご'),
      MyWord(word: '本', mean: '책', yomikata: 'ほん'),
      MyWord(word: 'アプリ', mean: '앱', yomikata: 'あぷり'),
    ];
  }

  @override
  void initState() {
    super.initState();
    loadData();
    wordController = TextEditingController();
    meanController = TextEditingController();
    yomikataController = TextEditingController();
    wordFocusNode = FocusNode();
    meanFocusNode = FocusNode();
    yomikataFocusNode = FocusNode();
  }

  @override
  void dispose() {
    wordController.dispose();
    meanController.dispose();
    yomikataController.dispose();
    yomikataController.dispose();
    meanFocusNode.dispose();
    wordFocusNode.dispose();
    super.dispose();
  }

  bool isFold = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.white),
            onPressed: () {
              isFold = !isFold;
              setState(() {});
            },
            child: Text(
              isFold ? '입력 상자 열기' : '입력 상자 접기',
              style: const TextStyle(
                color: Colors.black,
              ),
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: width > 500 ? 60 : 20),
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: isFold ? 0 : null,
                      width: isFold ? 0 : null,
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 32, right: 60, left: 60),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                autofocus: true,
                                focusNode: wordFocusNode,
                                onFieldSubmitted: (value) {},
                                controller: wordController,
                                decoration: const InputDecoration(
                                  label: Text(
                                    '일본어',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width > 500 ? 20 : 10),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                onFieldSubmitted: (value) {},
                                focusNode: yomikataFocusNode,
                                controller: yomikataController,
                                decoration: const InputDecoration(
                                  label: Text(
                                    '읽는 법',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width > 500 ? 20 : 10),
                            SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                onFieldSubmitted: (value) {},
                                focusNode: meanFocusNode,
                                controller: meanController,
                                decoration: const InputDecoration(
                                  label: Text(
                                    '의미',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width > 500 ? 20 : 10),
                            SizedBox(
                              width: double.infinity,
                              height: width > 500 ? 70 : 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {}),
                            )
                          ],
                        ),
                      ),
                    ),
                    // const Divider(),
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                  ],
                ),
                Positioned(
                    child: IconButton(
                  icon: const Icon(
                    Icons.flip,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.dialog(AlertDialog(
                      contentPadding: const EdgeInsets.symmetric(vertical: 2),
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: SizedBox(
                        width: 300,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    isOnlyKnown = true;
                                    isOnlyUnKnown = false;

                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  text: '암기 단어',
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  onTap: () {
                                    isOnlyUnKnown = true;
                                    isOnlyKnown = false;

                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  text: '미암기 단어',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    isOnlyKnown = false;
                                    isOnlyUnKnown = false;
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  text: '모든 단어',
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                    onTap: () {
                                      isWordFlip = !isWordFlip;
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    text: '문제 / 답 뒤집기')
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                )),
              ],
            ),

            // List
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(myWords.length, (index) {
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
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                icon: Icons.check,
                                label: myWords[myWords.length - 1 - index]
                                            .isKnown ==
                                        true
                                    ? 'Uknown'
                                    : 'Known',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: MyWordCard(
                              isWordFlip: isWordFlip,
                              myWord: myWords[myWords.length - 1 - index]),
                        ),
                      );
                    }),
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

class MyWordCard extends StatelessWidget {
  const MyWordCard({
    super.key,
    required this.myWord,
    required this.isWordFlip,
  });

  final MyWord myWord;
  final bool isWordFlip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.scaffoldBackground,
              title: KangiText(
                fontSize: 40,
                japanese: myWord.word,
                clickTwice: false,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '의미 : ${myWord.mean}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '읽는 법 : ${myWord.yomikata}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: myWord.isKnown
                    ? Colors.grey.withOpacity(0.7)
                    : Colors.white,
                offset: const Offset(0, 1),
              )
            ]),
        child: Center(child: Text(isWordFlip ? myWord.mean : myWord.word)),
      ),
    );
  }
}
