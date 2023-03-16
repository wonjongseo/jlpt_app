// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 0;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      word: fields[0] as String,
      mean: fields[2] as String,
      yomikata: fields[1] as String,
      isKnown: fields[3] as bool?,
      isLike: fields[4] as bool?,
      isMine: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.yomikata)
      ..writeByte(2)
      ..write(obj.mean)
      ..writeByte(3)
      ..write(obj.isKnown)
      ..writeByte(4)
      ..write(obj.isLike)
      ..writeByte(5)
      ..write(obj.isMine);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
