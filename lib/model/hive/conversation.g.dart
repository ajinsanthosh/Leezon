// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationAdapter extends TypeAdapter<Conversation> {
  @override
  final int typeId = 3;

  @override
  Conversation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversation(
      prompt: fields[0] as String,
      response: fields[1] as String,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.prompt)
      ..writeByte(1)
      ..write(obj.response)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
