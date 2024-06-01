import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xfinitive/Myfamily/todo.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo> _todosRef;

  DatabaseService(String userId) {
    _todosRef = _firestore
        .collection('users/$userId/myfamily')
        .withConverter<Todo>(
          fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
          toFirestore: (todo, _) => todo.toJson(),
        );
  }

  Stream<QuerySnapshot<Todo>> getTodos() {
    return _todosRef.snapshots();
  }

  Future<void> addTodo(Todo todo) async {
    await _todosRef.add(todo);
  }

  Future<void> updateTodo(String todoId, Todo todo) async {
    await _todosRef.doc(todoId).update(todo.toJson());
  }

  Future<void> deleteTodo(String todoId) async {
    await _todosRef.doc(todoId).delete();
  }
}