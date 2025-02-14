import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importar FirebaseAuth
import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/services/traslation_service.dart';

class TaskProvider with ChangeNotifier {
  final TranslationService translationService;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TaskProvider({required this.translationService});

  Future<void> addTask(Task task) async {
    try {
      final translatedTitle = await translationService.translate(task.title);
      final translatedDescription = await translationService.translate(task.description);

      final user = _auth.currentUser;

      if (user == null) {
        throw Exception("No hay usuario autenticado");
      }

      final Map<String, dynamic> taskData = {
        'title': translatedTitle,
        'description': translatedDescription,
        'status': task.status,
        'date': task.date,
        'createdAt': FieldValue.serverTimestamp(),
        'uid': user.uid,
      };

      await FirebaseFirestore.instance.collection("tasks").add(taskData);
    } catch (error) {
      rethrow;
    }
  }
}
