import 'package:flutter/material.dart';
// import 'package:goals_tracker/screens/test_screen.dart';
import 'package:goals_tracker/screens/main_screen.dart';
import 'package:goals_tracker/service/hive_service.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveService.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
      //TestScreen(),
    );
  }
}
