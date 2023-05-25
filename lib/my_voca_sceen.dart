import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

class MyVocaScreenTT extends StatefulWidget {
  const MyVocaScreenTT({super.key});

  @override
  State<MyVocaScreenTT> createState() => _MyVocaScreenTTState();
}

class _MyVocaScreenTTState extends State<MyVocaScreenTT> {
  List<MyWord> myWords = [];

  late TextEditingController wordController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;

  late FocusNode wordFocusNode;
  late FocusNode yomikataFocusNode;
  late FocusNode meanFocusNode;

  @override
  void initState() {
    super.initState();
    //  loadData();

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

    myWords.add(newWord);

    MyWordRepository.saveMyWord(newWord);

    wordController.clear();
    meanController.clear();
    yomikataController.clear();
    wordFocusNode.requestFocus();

    setState(() {});
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
                FlipButton(text: '암기 단어', onTap: () {}),
                const SizedBox(width: 10),
                FlipButton(text: '미암기 단어', onTap: () {}),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(text: '모든 단어', onTap: () {}),
                const SizedBox(width: 10),
                FlipButton(text: '뒤집기', onTap: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: TextButton(
          child: const Text(
            '안녕',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: changeFunc, icon: const Icon(Icons.flip))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MyWordInputField(
                saveWord: saveWord,
                wordFocusNode: wordFocusNode,
                wordController: wordController,
                yomikataFocusNode: yomikataFocusNode,
                yomikataController: yomikataController,
                meanFocusNode: meanFocusNode,
                meanController: meanController,
              ),
            ),
            const Divider(height: 40),
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0 || index == 3 + 1) {
                      return Divider(height: 0.5);
                    }
                    return Container(
                      width: double.infinity,
                      color: Colors.white,
                      height: 50,
                      child: const Center(
                          child: Text(
                        '食べる',
                        style: TextStyle(color: Colors.white),
                      )),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 3 + 2),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWordInputField extends StatelessWidget {
  const MyWordInputField({
    super.key,
    required this.wordFocusNode,
    required this.wordController,
    required this.yomikataFocusNode,
    required this.yomikataController,
    required this.meanFocusNode,
    required this.meanController,
    required this.saveWord,
  });

  final Function() saveWord;
  final FocusNode wordFocusNode;
  final TextEditingController wordController;
  final FocusNode yomikataFocusNode;
  final TextEditingController yomikataController;
  final FocusNode meanFocusNode;
  final TextEditingController meanController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 3,
              offset: const Offset(1, 1),
            ),
          ]),
      padding: const EdgeInsets.all(32),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              focusNode: wordFocusNode,
              onFieldSubmitted: (value) => saveWord(),
              controller: wordController,
              decoration: const InputDecoration(
                label: Text(
                  '일본어',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              focusNode: yomikataFocusNode,
              onFieldSubmitted: (value) => saveWord(),
              controller: yomikataController,
              decoration: const InputDecoration(
                label: Text(
                  '읽는 법',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              focusNode: meanFocusNode,
              onFieldSubmitted: (value) => saveWord(),
              controller: meanController,
              decoration: const InputDecoration(
                label: Text(
                  '의미',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveWord,
                child: const Text('저장'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FlipButton extends StatelessWidget {
  const FlipButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 130,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
