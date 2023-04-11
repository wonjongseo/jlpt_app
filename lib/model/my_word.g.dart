// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyWordAdapter extends TypeAdapter<MyWord> {
  @override
  final int typeId = 1;

  @override
  MyWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyWord(
      word: fields[0] as String,
      mean: fields[1] as String,
      yomikata: fields[3] as String,
    )..isKnown = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, MyWord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.mean)
      ..writeByte(3)
      ..write(obj.yomikata)
      ..writeByte(2)
      ..write(obj.isKnown);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
