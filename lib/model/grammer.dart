import 'package:hive/hive.dart';
import 'package:japanese_voca/model/my_word.dart';

@HiveType(typeId: 11)
class Grammar extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int step;
  @HiveField(2)
  final String level;
  @HiveField(3)
  final String grammar;
  @HiveField(4)
  final String connectionWays;

  @HiveField(5)
  final List<String> means;
  @HiveField(6)
  final List<MyWord> examples;

  final String description;

  Grammar(
      {required this.id,
      required this.step,
      required this.description,
      required this.level,
      required this.grammar,
      required this.connectionWays,
      required this.means,
      required this.examples});

  @override
  String toString() {
    return 'Grammar(id: $id, step: $step, level: $level, grammar: $grammar, connectionWays: $connectionWays, means: $means, exmaples: $examples, description: $description)';
  }
}

List<Grammar> dummy_grammers = [
  Grammar(
      description: 'description',
      id: 1,
      step: 0,
      level: '1',
      grammar: 'grammar',
      connectionWays: '1, 2, ,3 ,4',
      means: [
        '의미 1 입니다.',
        '의미 1 입니다. 2',
        '의미 1 입니다. 3'
      ],
      examples: [
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
        MyWord(
            word:
                'これはただの例題ですめっちゃ長く字になれ！！！おはようございます。これはただの例題ですめっちゃ長く字になれ！！！おはようございます。',
            mean: '안녕하사에 ㅛ, 제 이름은 원종서입니다. 잘 부탁들겠ㅅ브니다 .'),
      ]),
  Grammar(
      description: 'description',
      id: 2,
      step: 0,
      level: '1',
      grammar: 'grammar1',
      connectionWays: '1',
      means: ['2'],
      examples: [MyWord(word: '1', mean: 'mean2')]),
  Grammar(
      description: 'description',
      id: 3,
      step: 0,
      level: '1',
      grammar: 'grammar2',
      connectionWays: '1',
      means: ['2'],
      examples: [MyWord(word: '1', mean: 'mean2')]),
  Grammar(
      description: 'description',
      id: 4,
      step: 0,
      level: '1',
      grammar: 'grammar3',
      connectionWays: '1',
      means: ['2'],
      examples: [MyWord(word: '1', mean: 'mean2')]),
  Grammar(
      description: 'description',
      id: 5,
      step: 0,
      level: '1',
      grammar: 'grammar4',
      connectionWays: '1',
      means: ['2'],
      examples: [MyWord(word: '1', mean: 'mean2')]),
];
