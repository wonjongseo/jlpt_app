import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/word/n_word_study_sceen.dart';

final String WORD_PATH = '/word';

class WordSceen extends StatelessWidget {
  const WordSceen({super.key, required this.title});

  final String title;

  List<int> calculateButtonCount() {
    List<int> buttonCount = List.empty(growable: true);

    int full = (temp_words.length / 15).floor();
    for (int i = 0; i < full; i++) {
      buttonCount.add(15);
    }
    if (temp_words.length % 15 != 0) {
      buttonCount.add(temp_words.length % 15);
    }
    return buttonCount;
  }

  @override
  Widget build(BuildContext context) {
    List<int> buttonCount = calculateButtonCount();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20.0),
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        children: List.generate(
          buttonCount.length,
          (step) {
            List<Word> words =
                temp_words.sublist(step * 15, step * 15 + buttonCount[step]);
            return StepCard(
              words: words,
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
                      style: Theme.of(context).textTheme.displayMedium)),
            )));
  }
}
