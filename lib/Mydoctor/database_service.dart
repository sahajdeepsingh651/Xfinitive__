import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xfinitive/Mydoctor/doctor.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference<Todo2> _todosRef;

  DatabaseService(String userId) {
    _todosRef = _firestore
        .collection('users/$userId/doctors')
        .withConverter<Todo2>(
          fromFirestore: (snapshot, _) => Todo2.fromJson(snapshot.data()!),
          toFirestore: (todo, _) => todo.toJson(),
        );
  }

  Stream<QuerySnapshot<Todo2>> getTodos() {
    return _todosRef.snapshots();
  }

  Future<void> addTodo(Todo2 todo) async {
    await _todosRef.add(todo);
  }

  Future<void> updateTodo(String todoId, Todo2 todo) async {
    await _todosRef.doc(todoId).update(todo.toJson());
  }

  Future<void> deleteTodo(String todoId) async {
    await _todosRef.doc(todoId).delete();
  }
}
