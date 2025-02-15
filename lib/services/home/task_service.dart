import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/add_task_provider.dart';

class TaskService {
  Stream<QuerySnapshot> getUserTasks(String uid) {
    return FirebaseFirestore.instance
        .collection('tasks')
        .where('uid', isEqualTo: uid)
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> saveTask(Task task, AddTaskProvider taskProvider) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Usuario no autenticado");

      await taskProvider.addTask(task);
    } catch (error) {
      print("Error al agregar la tarea: $error");
    }
  }
}
