import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/new_app/models/new_voca.dart';
import 'package:japanese_voca/new_app/models/new_voca_example.dart';

class NewJapanese extends NewVoca {
  String yomikata;
  NewJapanese({
    required this.yomikata,
    required super.word,
    required super.mean,
    required super.examples,
  });

  // List<Kangi> kangis;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'yomikata': yomikata});
    result.addAll({'word': word});
    result.addAll({'mean': mean});
    result.addAll({'examples': examples.map((x) => x.toMap()).toList()});

    return result;
  }

  factory NewJapanese.fromMap(Map<String, dynamic> map) {
    return NewJapanese(
      yomikata: map['yomikata'] ?? '',
      word: map['word'] ?? '',
      mean: map['mean'] ?? '',
      examples: List<NewVocaExample>.from(
          map['examples']?.map((x) => NewVocaExample.fromMap(x))),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory NewJapanese.fromJson(String source) =>
      NewJapanese.fromMap(json.decode(source));

  @override
  String toString() => 'NewJapanese(yomikata: $yomikata)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewJapanese && other.yomikata == yomikata;
  }

  @override
  int get hashCode => yomikata.hashCode;
}
