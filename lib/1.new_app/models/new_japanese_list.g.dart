// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_japanese_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewJapaneseListAdapter extends TypeAdapter<NewJapaneseList> {
  @override
  final int typeId = 24;

  @override
  NewJapaneseList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewJapaneseList(
      level: fields[0] as int,
      chatper: fields[1] as int,
      japaneses: (fields[2] as List).cast<NewJapanese>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewJapaneseList obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.chatper)
      ..writeByte(2)
      ..write(obj.japaneses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewJapaneseListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
