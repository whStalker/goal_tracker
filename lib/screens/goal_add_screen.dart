import 'package:flutter/material.dart';
import 'package:goals_tracker/model/goal_model.dart';
import 'package:goals_tracker/service/hive_service.dart';
import 'package:intl/intl.dart';

class GoalAddScreen extends StatefulWidget {
  const GoalAddScreen({super.key});

  @override
  State<GoalAddScreen> createState() => _GoalAddScreenState();
}

TextEditingController _goalTitleController = TextEditingController();
TextEditingController _goalPlanController = TextEditingController();

class _GoalAddScreenState extends State<GoalAddScreen> {
  final List _goalPlanList = [];
  DateTime dateTime = DateTime.now();

  // goal plan add dialog
  void enterGoalPlan(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: TextField(
                controller: _goalPlanController,
                autofocus: true,
                onSubmitted: (value) {
                  setState(() {
                    _goalPlanList.add(value);
                  });
                  _goalPlanController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // goal plan edit dialog
  void editGoalPlan(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      elevation: 5,
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: TextField(
                controller: TextEditingController(text: _goalPlanList[index]),
                autofocus: true,
                onSubmitted: (value) {
                  setState(() {
                    _goalPlanList.removeAt(index);
                    _goalPlanList.insert(index, value);
                  });
                  _goalPlanController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: TextField(
              maxLines: null,
              controller: _goalTitleController,
              decoration: const InputDecoration(
                hintText: 'Заголовок',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Дедлайн',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // select date time
                    DateTime? selectDeadline = await showDatePicker(
                      context: context,
                      initialDate: dateTime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );

                    if (selectDeadline == null) return;
                    setState(() => dateTime = selectDeadline);
                  },
                  child: Text(
                    DateFormat('dd:MM:yyyy').format(dateTime).toString(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'План реализации',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    enterGoalPlan(context);
                  },
                  child: const Text(
                    'Добавить план',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          const Divider(
            height: 20,
            indent: 20,
            endIndent: 20,
            color: Colors.black38,
            thickness: 2,
          ),

          // Show goal plan list

          Expanded(
            child: ListView.builder(
              itemCount: _goalPlanList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            _goalPlanList[index],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  editGoalPlan(context, index);
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _goalPlanList.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          setState(() {
            HiveService.addGoal(
              GoalListModel(
                goalTitle: _goalTitleController.text,
                goalPlan: _goalPlanList,
                goalDeadline: DateFormat('dd:MM:yyyy').format(dateTime),
              ),
            );
            _goalTitleController.clear();

            Navigator.pop(context);
          });
        },
        child: const Text('Save'),
      ),
    );
  }
}
