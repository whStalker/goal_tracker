import 'package:goals_tracker/model/goal_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  static initHive() async {
    Hive.registerAdapter(GoalListModelAdapter());

    // await Hive.deleteBoxFromDisk('goals');

    await Hive.openBox<GoalListModel>('goals');
  }

  static void addGoal(GoalListModel goalListModel) {
    Hive.box<GoalListModel>('goals').add(goalListModel);
  }

  static List<GoalListModel> getGoal() {
    final result = Hive.box<GoalListModel>('goals').values.toList();

    return result;
  }

  static void editGoal(int index, GoalListModel goalListModel) {
    Hive.box<GoalListModel>('goals').putAt(index, goalListModel);
  }

  static deleteGoal(int index) {
    Hive.box<GoalListModel>('goals').deleteAt(index);
  }
}
