import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/widgets/snackbar.dart';

class Delete extends ChangeNotifier {
  bool _isButtonDisabled = false;

  bool get isButtonDisabled => _isButtonDisabled;

  void setButtonState(bool state) {
    _isButtonDisabled = state;
    notifyListeners();
  }

  Future<void> deleteTask(String taskId, BuildContext context) async {
    try {
      setButtonState(true);
      await FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();

      showCustomSnackBar(
        context,
        message: "Tarea eliminada exitosamente",
        colorPrincipal: Colors.green,
        colorIcon: Colors.white,
        borderColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      showCustomSnackBar(
        context,
        message: "Error al eliminar tarea: $e",
        colorPrincipal: Colors.red,
        colorIcon: Colors.white,
        borderColor: Colors.red,
        icon: Icons.error,
      );
    } finally {
      setButtonState(false);
    }
  }
}
