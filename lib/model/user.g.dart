// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 15;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      heartCount: fields[0] as int,
      jlptWordScroes: (fields[1] as List).cast<int>(),
      grammarScores: (fields[2] as List).cast<int>(),
      kangiScores: (fields[3] as List).cast<int>(),
      currentJlptWordScroes: (fields[4] as List).cast<int>(),
      currentGrammarScores: (fields[5] as List).cast<int>(),
      currentKangiScores: (fields[6] as List).cast<int>(),
    )
      ..countMyWords = fields[7] == null ? 0 : fields[7] as int
      ..yokumatigaeruMyWords = fields[8] == null ? 0 : fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(9)
      ..writeByte(7)
      ..write(obj.countMyWords)
      ..writeByte(5)
      ..write(obj.currentGrammarScores)
      ..writeByte(4)
      ..write(obj.currentJlptWordScroes)
      ..writeByte(6)
      ..write(obj.currentKangiScores)
      ..writeByte(2)
      ..write(obj.grammarScores)
      ..writeByte(0)
      ..write(obj.heartCount)
      ..writeByte(1)
      ..write(obj.jlptWordScroes)
      ..writeByte(3)
      ..write(obj.kangiScores)
      ..writeByte(8)
      ..write(obj.yokumatigaeruMyWords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
