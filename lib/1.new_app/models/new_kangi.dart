import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

import 'package:japanese_voca/1.new_app/models/new_voca.dart';
import 'package:japanese_voca/1.new_app/models/new_voca_example.dart';
import 'package:japanese_voca/model/hive_type.dart';

part 'new_kangi.g.dart';

@HiveType(typeId: NewKangiId)
class NewKangi extends NewVoca {
  static String boxKey = 'new_kangi_key';
  @HiveField(4)
  String undoc;
  @HiveField(5)
  String hundoc;
  NewKangi({
    required this.undoc,
    required this.hundoc,
    required super.word,
    required super.mean,
    required super.examples,
    super.isSaved = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'undoc': undoc});
    result.addAll({'hundoc': hundoc});
    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});
    result.addAll({'isSaved': isSaved});

    return result;
  }

  factory NewKangi.fromMap(Map<String, dynamic> map) {
    return NewKangi(
      undoc: map['undoc'] ?? '',
      hundoc: map['hundoc'] ?? '',
      word: map['word'] ?? '',
      mean: map['mean'] ?? '',
      examples: List<NewVocaExample>.from(
          map['examples']?.map((x) => NewVocaExample.fromMap(x))),
      isSaved: map['isSaved'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewKangi.fromJson(String source) =>
      NewKangi.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewKangi(undoc: $undoc, hundoc: $hundoc ${super.toString()})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewKangi && other.undoc == undoc && other.hundoc == hundoc;
  }

  @override
  int get hashCode => undoc.hashCode ^ hundoc.hashCode;
}
