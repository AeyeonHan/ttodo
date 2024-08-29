import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

const _uuid = Uuid();

enum Importance {
  low,
  middle,
  high,
}

@immutable
class Todo {
  const Todo(
      {required this.id,
      required this.description,
      this.importance = Importance.low,
      this.completed = false});

  final String id;
  final String description;
  final Importance importance;
  final bool completed;
}

@riverpod
class TodoProvider extends _$TodoProvider {
  @override
  List<Todo> build() => [
        const Todo(id: 'task0', description: '집에 가기'),
        const Todo(id: 'task1', description: 'Go home'),
        const Todo(
            id: 'task2', description: '진짜 갈래', importance: Importance.high),
      ];

  void add(String desc) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: desc,
      )
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
            importance: todo.importance,
          )
        else
          todo,
    ];
  }

  void changeImportance(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
              id: todo.id,
              completed: todo.completed,
              description: todo.description,
              importance: (todo.importance == Importance.low)
                  ? Importance.middle
                  : (todo.importance == Importance.middle)
                      ? Importance.high
                      : Importance.low)
        else
          todo,
    ];
  }
// countUp(value) {
//   update((count) async {
//     count += value;
//     return count;
//   });
// }
}
