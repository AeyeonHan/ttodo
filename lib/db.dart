import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todos';
final String columnId = 'id';
final String columnDescription = 'description';
final String columnImportance = 'importance';
final String columnCompleted = 'completed';

class Todo {
  late int? id;
  late String description;
  late String importance;
  late bool completed;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnDescription: description,
      columnImportance: importance,
      columnCompleted: completed == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo(
      {this.id,
      this.description = '',
      this.importance = 'low',
      this.completed = false});

  Todo.fromMap(Map<String, Object?> map) {
    id = int.parse(map[columnId].toString());
    description = map[columnDescription].toString();
    importance = map[columnImportance].toString();
    completed = map[columnCompleted] == 0;
  }
}

class TodoProvider {
  late Database db;

  Future open(String path) async {
    //데이터베이스 자체를 삭제함
    // deleteDatabase('todos.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnDescription text not null,
  $columnImportance text not null,
  $columnCompleted integer not null)
''');
    });
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  Future<List<Map<String, Object?>>> getList() async {
    List<Map<String, Object?>> records = await db.query(tableTodo);
    return records;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [
          columnId,
          columnDescription,
          columnImportance,
          columnCompleted
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first as Map<String, Object?>);
    }
    return Todo(); //원래 null 리턴이었음
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
