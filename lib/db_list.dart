import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'db.dart';

class DBList extends ConsumerWidget {
  // const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final List<Todo> todoList = ref.watch(todoProviderProvider);
    // final todoNotifier = ref.watch(todoProviderProvider.notifier);
    // final TextEditingController _controller = TextEditingController();

    TodoProvider db = TodoProvider();

    void getList() async {
      await db.open('todos.db');

      Todo todo =
          Todo(description: '3차성공', importance: 'middle', completed: false);
      // var iresult = await db.insert(todo);

      // var idelete = await db.delete(1);
      var list = await db.getList();
      print(list);
    }

    getList();

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
