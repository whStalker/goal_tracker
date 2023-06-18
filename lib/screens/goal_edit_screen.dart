import 'package:flutter/material.dart';
import 'package:goals_tracker/model/goal_model.dart';
import 'package:goals_tracker/service/hive_service.dart';
import 'package:intl/intl.dart';

class GoalEditScreen extends StatefulWidget {
  final int index;
  final String goalTitle;
  final String goalDeadline;
  final List goalPlan;

  const GoalEditScreen(
      {required this.index,
      required this.goalTitle,
      required this.goalDeadline,
      required this.goalPlan,
      super.key});

  @override
  State<GoalEditScreen> createState() => _GoalEditScreenState();
}

TextEditingController _goalTitleController = TextEditingController();
TextEditingController _goalPlanController = TextEditingController();

class _GoalEditScreenState extends State<GoalEditScreen> {
  DateTime dateTime = DateTime.now();

  @override
  void didChangeDependencies() {
    _goalTitleController = TextEditingController(text: widget.goalTitle);
    super.didChangeDependencies();
  }

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
                    widget.goalPlan.add(value);
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
                controller: TextEditingController(text: widget.goalPlan[index]),
                autofocus: true,
                onSubmitted: (value) {
                  setState(() {
                    widget.goalPlan.removeAt(index);
                    widget.goalPlan.insert(index, value);
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
                Text(
                  widget.goalDeadline,
                  style: const TextStyle(fontSize: 18),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     DateTime? selectDeadline = await showDatePicker(
                //       context: context,
                //       initialDate: _date,
                //       firstDate: DateTime.now(),
                //       lastDate: DateTime(2100),
                //     );

                //     if (selectDeadline == null) return;
                //     setState(() => dateTime = selectDeadline);
                //   },
                //   child: Text(
                //     // _date.toString(),
                //     DateFormat('dd:MM:yyyy').format(_date).toString(),
                //   ),
                // ),
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
              itemCount: widget.goalPlan.length,
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
                            widget.goalPlan[index],
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
                                  widget.goalPlan.removeAt(index);
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
            HiveService.editGoal(
              widget.index,
              GoalListModel(
                goalTitle: _goalTitleController.text,
                goalPlan: widget.goalPlan,
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
