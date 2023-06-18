// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalListModelAdapter extends TypeAdapter<GoalListModel> {
  @override
  final int typeId = 0;

  @override
  GoalListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalListModel(
      goalTitle: fields[0] as String,
      goalPlan: (fields[1] as List).cast<dynamic>(),
      goalDeadline: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GoalListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.goalTitle)
      ..writeByte(1)
      ..write(obj.goalPlan)
      ..writeByte(2)
      ..write(obj.goalDeadline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
