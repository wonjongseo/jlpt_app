import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/hive_type.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/1.new_app/models/new_voca.dart';
import 'package:japanese_voca/1.new_app/models/new_voca_example.dart';

part 'new_japanese.g.dart';

@HiveType(typeId: NewJapaneseId)
class NewJapanese extends NewVoca {
  static String boxKey = 'new_japanese_key';

  @HiveField(4)
  String yomikata;
  NewJapanese({
    required this.yomikata,
    required super.word,
    required super.mean,
    required super.examples,
    super.isSaved = false,
  });

  // List<Kangi> kangis;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'yomikata': yomikata});
    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});
    result.addAll({'isSaved': isSaved});
    return result;
  }

  factory NewJapanese.fromMap(Map<String, dynamic> map) {
    return NewJapanese(
      yomikata: map['yomikata'] ?? '',
      word: map['word'] ?? '',
      mean: map['mean'] ?? '',
      examples: List<NewVocaExample>.from(
          map['examples']?.map((x) => NewVocaExample.fromMap(x))),
      isSaved: map['isSaved'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory NewJapanese.fromJson(String source) =>
      NewJapanese.fromMap(json.decode(source));

  @override
  String toString() => 'NewJapanese(yomikata: $yomikata, ${super.toString()})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewJapanese && other.yomikata == yomikata;
  }

  @override
  int get hashCode => yomikata.hashCode;
}
