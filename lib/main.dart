import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo_list.dart';
import 'db_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('✔ ttodo'),
            backgroundColor: Colors.lightGreen.shade100,
          ),
          body: DBList(),
          // body: TodoList(),
        ),
      ),
    );
  }
}
