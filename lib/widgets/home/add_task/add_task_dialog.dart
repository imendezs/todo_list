import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/add_task_provider.dart';
import 'package:todo_list/services/home/task_service.dart';
import 'package:todo_list/screens/home/add_task/task_form.dart';
import 'package:todo_list/utils/home/task_form_controller.dart';
import 'package:todo_list/widgets/responsive_helper.dart';
import 'package:todo_list/widgets/snackbar.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TaskFormController _controller = TaskFormController();
  final TaskService _taskService = TaskService();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveTask(BuildContext context) async {
    final responsive = ResponsiveHelper(context);

    try {
      if (_controller.dateController.text.isEmpty) {
        showCustomSnackBar(
          context,
          message: "Debe seleccionar una fecha",
          colorPrincipal: Colors.amber.shade600,
          colorIcon: Colors.white70,
          borderColor: Colors.amber,
          icon: Icons.warning,
        );
        return;
      }

      if (_controller.titleController.text.isEmpty && _controller.descriptionController.text.isEmpty) {
        showCustomSnackBar(
          context,
          message: "Debe rellenar todos los campos",
          colorPrincipal: Colors.amber.shade600,
          colorIcon: Colors.white70,
          borderColor: Colors.amber,
          icon: Icons.warning,
        );
        return;
      }

      DateTime selectedDate = DateTime.parse(_controller.dateController.text);
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        showCustomSnackBar(
          context,
          message: "Usuario no autenticado. Inicie sesión para continuar.",
          colorPrincipal: Colors.red.shade600,
          colorIcon: Colors.white70,
          borderColor: Colors.red,
          icon: Icons.error,
        );
        return;
      }

      final task = Task(
        title: _controller.titleController.text,
        description: _controller.descriptionController.text,
        status: _controller.selectedStatus,
        date: selectedDate,
        userId: user.uid,
      );

      final taskProvider = Provider.of<AddTaskProvider>(context, listen: false);
      await _taskService.saveTask(task, taskProvider);

      showCustomSnackBar(
        context,
        message: "Tarea agregada exitosamente",
        colorPrincipal: Color(0xFF00BF6D),
        colorIcon: Colors.white70,
        borderColor: Color(0xFF00BF6D),
        icon: Icons.check_circle,
      );
      Navigator.of(context).pop();
    } catch (error) {
      showCustomSnackBar(
        context,
        message: "Ocurrió un error al guardar la tarea. Inténtalo nuevamente.",
        colorPrincipal: Colors.grey.shade600,
        colorIcon: Colors.white70,
        borderColor: Colors.grey,
        icon: Icons.error_outline,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<AddTaskProvider>(context);
    final responsive = ResponsiveHelper(context);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Agregar Tarea",
        style: TextStyle(fontSize: responsive.textLarge),
      ),
      content: TaskForm(controller: _controller),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(
              horizontal: responsive.paddingMedium,
              vertical: responsive.paddingSmall,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(responsive.borderRadiusMedium),
            ),
          ),
          child: Text(
            "Cancelar",
            style: TextStyle(fontSize: responsive.textSmall),
          ),
        ),
        TextButton(
          onPressed: taskProvider.isButtonDisabled
              ? null
              : () async {
                  taskProvider.setButtonDisabled(true);
                  try {
                    final task = Task(
                      title: _controller.titleController.text,
                      description: _controller.descriptionController.text,
                      status: _controller.selectedStatus,
                      date: DateTime.parse(_controller.dateController.text),
                      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                    );

                    await _taskService.saveTask(task, taskProvider);
                    Navigator.pop(context);
                  } catch (e) {
                    print("Error al guardar la tarea: $e");
                  } finally {
                    taskProvider.setButtonDisabled(false);
                  }
                },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF00BF6D),
            padding: EdgeInsets.symmetric(horizontal: responsive.paddingMedium, vertical: responsive.paddingSmall),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.borderRadiusSmall)),
          ),
          child: taskProvider.isButtonDisabled
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text("Guardar", style: TextStyle(fontSize: responsive.textSmall)),
        ),
      ],
    );
  }
}
