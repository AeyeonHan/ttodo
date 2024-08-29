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
class Task {
  const Task(
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
  List<Task> build() => [
        const Task(id: 'task0', description: '집에 가기'),
        const Task(id: 'task1', description: 'Go home'),
        const Task(
            id: 'task2', description: '진짜 갈래', importance: Importance.high),
      ];

  void add(String desc) {
    state = [
      ...state,
      Task(
        id: _uuid.v4(),
        description: desc,
      )
    ];
  }
// countUp(value) {
//   update((count) async {
//     count += value;
//     return count;
//   });
// }
}
