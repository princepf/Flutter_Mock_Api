import 'package:flutter/material.dart';
import 'package:flutter_mock_api/pages/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Person Name',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TaskList(),
    );
  }
}
