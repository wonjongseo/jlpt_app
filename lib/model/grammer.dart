import 'package:hive/hive.dart';
import 'package:japanese_voca/model/my_word.dart';

@HiveType(typeId: 11)
class Grammar extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late int step;
  @HiveField(2)
  late String level;
  @HiveField(3)
  late String grammar;
  @HiveField(4)
  late String connectionWays;

  @HiveField(5)
  late String means;
  @HiveField(6)
  late List<MyWord> examples;

  late String description;

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

  Grammar.fromMap(Map<String, dynamic> map) {
    List<MyWord> myWords = List.generate(map['examples'].length,
        (index) => MyWord.fromMap(map['examples'][index]));

    id = map['id'] ?? -1;
    step = map['step'] ?? -1;
    description = map['description'] ?? '';
    level = map['level'] ?? '';
    grammar = map['grammar'] ?? '';
    connectionWays = map['connectionWays'] ?? '';
    means = map['means'] ?? '';
    examples = myWords ?? [];
  }
}
