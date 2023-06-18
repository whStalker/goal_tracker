import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:goals_tracker/screens/goal_edit_screen.dart';

// import 'package:hive/hive.dart';

import 'package:goals_tracker/model/goal_model.dart';
import 'package:goals_tracker/screens/goal_add_screen.dart';
import 'package:goals_tracker/service/hive_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GoalListModel> goalList = <GoalListModel>[];

  @override
  Widget build(BuildContext context) {
    goalList = HiveService.getGoal();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goal Tracker'),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       setState(() {
        //         Hive.box<GoalListModel>('goals').clear();
        //       });
        //     },
        //     icon: const Icon(Icons.delete),
        //   ),
        // ],
      ),
      body: ListView.builder(
        itemCount: goalList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Route route = MaterialPageRoute(
                builder: (context) => GoalEditScreen(
                  index: index,
                  goalTitle: goalList[index].goalTitle,
                  goalDeadline: goalList[index].goalDeadline,
                  goalPlan: goalList[index].goalPlan,
                ),
              );
              await Navigator.push(context, route);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 5,
                top: 10,
                bottom: 10,
              ),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          HiveService.deleteGoal(index);
                        });
                      },
                      borderRadius: BorderRadius.circular(15),
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              goalList[index].goalTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              goalList[index].goalDeadline,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.all(0),
      //   child: Expanded(
      //     child: ListView.builder(
      //       itemCount: goalList.length,
      //       itemBuilder: (context, index) {
      //         return Column(
      //           children: [
      //             GestureDetector(
      //               onTap: () async {
      //                 Route route = MaterialPageRoute(
      //                   builder: (context) => GoalEditScreen(
      //                     index: index,
      //                     goalTitle: goalList[index].goalTitle,
      //                     goalDeadline: goalList[index].goalDeadline,
      //                     goalPlan: goalList[index].goalPlan,
      //                   ),
      //                 );
      //                 await Navigator.push(context, route);
      //                 setState(() {});
      //               },
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                   horizontal: 5,
      //                   vertical: 5,
      //                 ),
      //                 child: Card(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.all(10.0),
      //                             child: Text(
      //                               goalList[index].goalTitle,
      //                               style: const TextStyle(
      //                                 fontSize: 22,
      //                                 fontWeight: FontWeight.w700,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.end,
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.all(10.0),
      //                             child: Text(
      //                               goalList[index].goalDeadline.toString(),
      //                               style: const TextStyle(
      //                                 fontSize: 15,
      //                                 color: Colors.black45,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       // SizedBox(
      //                       //   height: 300,
      //                       //   child: ListView.builder(
      //                       //     physics: const NeverScrollableScrollPhysics(),
      //                       //     itemCount: goalList[index].goalPlan.length,
      //                       //     itemBuilder: (context, id) {
      //                       //       return Text(
      //                       //         goalList[index].goalPlan[id],
      //                       //       );
      //                       //     },
      //                       //   ),
      //                       // ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         );
      //       },
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Route route = MaterialPageRoute(
            builder: (context) => const GoalAddScreen(),
          );
          await Navigator.push(context, route);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
