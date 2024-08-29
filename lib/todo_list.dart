import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'todo.dart';

class TodoList extends ConsumerWidget {
  // const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todoList = ref.watch(todoProviderProvider);
    final todoNotifier = ref.watch(todoProviderProvider.notifier);
    final TextEditingController _controller = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: (value) {
                todoNotifier.add(value);
              },
              decoration: InputDecoration(
                hintText: '화이팅🙏',
                filled: true,
                fillColor: Colors.lightGreen.shade50,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade900,
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green.shade900,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                for (var todo in todoList)
                  GestureDetector(
                    child: Text(
                      todo.description,
                      style: TextStyle(
                        color: ((todo.importance == Importance.high)
                            ? Colors.red
                            : (todo.importance == Importance.middle)
                                ? Colors.blue
                                : Colors.black),
                        decoration: (todo.completed)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    onTap: () {
                      todoNotifier.changeImportance(todo.id);
                      // ref.watch(todoProviderProvider.notifier).state
                      print('onTap: ${todo.description}');
                    },
                    onLongPress: () {
                      print('onLongPress: ${todo.description}');
                    },
                    onDoubleTap: () {
                      todoNotifier.toggle(todo.id);
                      print('onDoubleTap: ${todo.description}');
                    },
                  ),
              ],
            )
            // Column(
            //   children: todoList
            //       .map(
            //         (e) => Text(
            //           '${e.description}',
            //           style: TextStyle(
            //               color: ((e.importance == Importance.high)
            //                   ? Colors.red
            //                   : (e.importance == Importance.middle)
            //                       ? Colors.blue
            //                       : Colors.black)),
            //         ),
            //       )
            //       .toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
