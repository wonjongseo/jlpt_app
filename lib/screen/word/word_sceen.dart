import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

final String WORD_PATH = '/word';

class WordSceen extends StatefulWidget {
  const WordSceen({super.key, required this.title, required this.words});

  final String title;
  final List<Word> words;

  @override
  State<WordSceen> createState() => _WordSceenState();
}

class _WordSceenState extends State<WordSceen> {
  List<int> buttonCount = [];
  late LocalReposotiry localReposotiry;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    localReposotiry = LocalReposotiry();

    buttonCount = calculateButtonCount();
  }

  List<int> calculateButtonCount() {
    List<int> buttonCount = List.empty(growable: true);

    int full = (widget.words.length / 15).floor();
    for (int i = 0; i < full; i++) {
      buttonCount.add(15);
    }
    if (widget.words.length % 15 != 0) {
      buttonCount.add(widget.words.length % 15);
    }
    return buttonCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: widget.words.isEmpty
          ? CircularProgressIndicator()
          : GridView.count(
              padding: const EdgeInsets.all(20.0),
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              children: List.generate(
                buttonCount.length,
                (step) {
                  List<Word> splitedwords = widget.words
                      .sublist(step * 15, step * 15 + buttonCount[step]);
                  return StepCard(
                    words: splitedwords,
                    step: step,
                  );
                },
              ),
            ),
    );
  }
}

class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.words,
    required this.step,
  });

  final int step;

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => NWordStudyScreen(words: words));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.correctColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: GridTile(
          footer: Center(
            child: Text('${0} / ${words.length}'),
          ),
          child: Center(
            child: Text((step + 1).toString(),
                style: Theme.of(context).textTheme.displayMedium),
          ),
        ),
      ),
    );
  }
}
