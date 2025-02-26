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
      jlptWordScroes: (fields[1] as List).cast<int>(),
      grammarScores: (fields[2] as List).cast<int>(),
      kangiScores: (fields[3] as List).cast<int>(),
      currentJlptWordScroes: (fields[4] as List).cast<int>(),
      currentGrammarScores: (fields[5] as List).cast<int>(),
      currentKangiScores: (fields[6] as List).cast<int>(),
    )
      ..isPremieum = fields[100] == null ? true : fields[100] as bool
      ..yokumatigaeruMyWords = fields[8] == null ? 0 : fields[8] as int
      ..manualSavedMyWords = fields[99] == null ? 0 : fields[99] as int
      ..isTrik = fields[101] == null ? false : fields[101] as bool;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(5)
      ..write(obj.currentGrammarScores)
      ..writeByte(4)
      ..write(obj.currentJlptWordScroes)
      ..writeByte(6)
      ..write(obj.currentKangiScores)
      ..writeByte(2)
      ..write(obj.grammarScores)
      ..writeByte(100)
      ..write(obj.isPremieum)
      ..writeByte(1)
      ..write(obj.jlptWordScroes)
      ..writeByte(3)
      ..write(obj.kangiScores)
      ..writeByte(8)
      ..write(obj.yokumatigaeruMyWords)
      ..writeByte(99)
      ..write(obj.manualSavedMyWords)
      ..writeByte(101)
      ..write(obj.isTrik);
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
