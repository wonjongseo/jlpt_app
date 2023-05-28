import 'dart:math';

import 'package:japanese_voca/model/word.dart';

class Question {
  final int answer;
  final Word question;
  final List<Word> options;

  Question({
    required this.question,
    required this.answer,
    required this.options,
  });

  @override
  String toString() {
    return 'Question{answer: $answer,question: $question, options: $options}';
  }

  static Map<int, List<Word>> generateAnswer(
      List<Word> vocas, int currentIndex) {
    Random random = Random();

    List<int> answerIndex = List.empty(growable: true);

    for (int i = 0; i < 4; i++) {
      int randomNumber = random.nextInt(vocas.length);
      while (answerIndex.contains(randomNumber)) {
        randomNumber = random.nextInt(vocas.length);
      }
      answerIndex.add(randomNumber);
    }

    int correctIndex = answerIndex.indexOf(currentIndex);
    if (correctIndex == -1) {
      int randomNumber = random.nextInt(4);
      answerIndex[randomNumber] = currentIndex;
      correctIndex = randomNumber;
    }

    List<Word> answerVoca = List.empty(growable: true);

    for (int j = 0; j < answerIndex.length; j++) {
      Word newWord = Word(
          id: vocas[answerIndex[j]].id,
          word: vocas[answerIndex[j]].word,
          mean: vocas[answerIndex[j]].mean,
          yomikata: vocas[answerIndex[j]].yomikata,
          headTitle: vocas[answerIndex[j]].headTitle);

      answerVoca.add(newWord);
    }

    return {correctIndex: answerVoca};
  }

  static List<Map<int, List<Word>>> generateQustion(List<Word> vocas) {
    List<Map<int, List<Word>>> map = List.empty(growable: true);
    for (int correntIndex = 0; correntIndex < vocas.length; correntIndex++) {
      Map<int, List<Word>> voca = generateAnswer(vocas, correntIndex);
      map.add(voca);
    }
    map.shuffle();

    return map;
  }
}
