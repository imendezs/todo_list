import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateService {
  Future<void> updateTaskStatus(String taskId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .update({'status': newStatus});
    } catch (e) {
      throw Exception("Error al actualizar estado: $e");
    }
  }
}
