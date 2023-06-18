import 'package:hive/hive.dart';

part 'goal_model.g.dart';

@HiveType(typeId: 0)
class GoalListModel {
  @HiveField(0)
  final String goalTitle;

  @HiveField(1)
  final List goalPlan;

  @HiveField(2)
  final String goalDeadline;

  GoalListModel({
    required this.goalTitle,
    required this.goalPlan,
    required this.goalDeadline,
  });
}
