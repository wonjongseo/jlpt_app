import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:japanese_voca/common/network_manager.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/hive_type.dart';

part 'grammar.g.dart';

@HiveType(typeId: GrammarTypeId)
class Grammar extends HiveObject {
  static String boxKey = 'grammer_key';
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
  late List<Example> examples;
  @HiveField(7)
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
    return 'Grammar(id: $id, step: $step, level: "$level", grammar: "$grammar", connectionWays: "$connectionWays", means: "$means", examples: $examples, description: "$description")';
  }

  Grammar.fromMap(Map<String, dynamic> map) {
    List<Example> myWords = List.generate(map['examples'].length,
        (index) => Example.fromMap(map['examples'][index]));

    id = map['id'] ?? -1;
    step = map['step'] ?? -1;
    description = map['description'] ?? '';
    level = map['level'] ?? '';
    grammar = map['grammar'] ?? '';
    connectionWays = map['connectionWays'] ?? '';
    means = map['means'] ?? '';
    examples = myWords;
  }

  static Future<List<Grammar>> jsonToObject(String nLevel) async {
    log('jsonToObjectGrammar');

    var json_grammars = [];

    if (nLevel == '1') {
      // json_grammars = json_grammars_n1;
      json_grammars = NetWorkManager.getDataToServer('N1-grammar');
    } else if (nLevel == '2') {
      // json_grammars = json_grammars_n2;
      json_grammars = NetWorkManager.getDataToServer('N2-grammar');
    } else if (nLevel == '3') {
      // json_grammars = json_grammars_n3;
      json_grammars = NetWorkManager.getDataToServer('N3-grammar');
    }

    List<Grammar> grammars = [];

    for (int i = 0; i < json_grammars.length; i++) {
      Grammar grammar = Grammar.fromMap(json_grammars[i]);
      grammars.add(grammar);
    }
    grammars.shuffle();

    return grammars;
  }
}
