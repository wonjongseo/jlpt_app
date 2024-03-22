import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:japanese_voca/1.new_app/models/new_japanese.dart';
import 'package:japanese_voca/model/hive_type.dart';

part 'new_japanese_list.g.dart';

@HiveType(typeId: NewJapaneseListId)
class NewJapaneseList {
  static String boxKey = 'new_japanese_list_key';
  @HiveField(0)
  int level;
  @HiveField(1)
  int chatper;
  @HiveField(2)
  List<NewJapanese> japaneses;
  NewJapaneseList({
    required this.level,
    required this.chatper,
    required this.japaneses,
  });

  NewJapaneseList copyWith({
    int? level,
    int? chatper,
    List<NewJapanese>? japaneses,
  }) {
    return NewJapaneseList(
      level: level ?? this.level,
      chatper: chatper ?? this.chatper,
      japaneses: japaneses ?? this.japaneses,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'level': level});
    result.addAll({'chatper': chatper});
    result.addAll({'japaneses': japaneses.map((x) => x.toMap()).toList()});

    return result;
  }

  factory NewJapaneseList.fromMap(Map<String, dynamic> map) {
    return NewJapaneseList(
      level: map['level']?.toInt() ?? 0,
      chatper: map['chatper']?.toInt() ?? 0,
      japaneses: List<NewJapanese>.from(
          map['japaneses']?.map((x) => NewJapanese.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewJapaneseList.fromJson(String source) =>
      NewJapaneseList.fromMap(json.decode(source));

  @override
  String toString() =>
      'NewJapaneseList(level: $level, chatper: $chatper, japaneses: $japaneses)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewJapaneseList &&
        other.level == level &&
        other.chatper == chatper &&
        listEquals(other.japaneses, japaneses);
  }

  @override
  int get hashCode => level.hashCode ^ chatper.hashCode ^ japaneses.hashCode;
}
