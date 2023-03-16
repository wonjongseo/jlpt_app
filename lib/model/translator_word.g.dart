// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translator_word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TranslatorWordAdapter extends TypeAdapter<TranslatorWord> {
  @override
  final int typeId = 3;

  @override
  TranslatorWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TranslatorWord(
      originalLan: fields[3] as String,
      target1Lan: fields[4] as String,
      target2Lan: fields[5] as String,
      originalWord: fields[0] as String,
      target1Word: fields[1] as String,
      target2Word: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TranslatorWord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.originalWord)
      ..writeByte(1)
      ..write(obj.target1Word)
      ..writeByte(2)
      ..write(obj.target2Word)
      ..writeByte(3)
      ..write(obj.originalLan)
      ..writeByte(4)
      ..write(obj.target1Lan)
      ..writeByte(5)
      ..write(obj.target2Lan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TranslatorWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
