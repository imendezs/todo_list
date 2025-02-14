import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/services/home/task_service.dart';
import 'package:todo_list/screens/home/add_task/task_form.dart';
import 'package:todo_list/widgets/home/add_task/task_form_controller.dart';
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

      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      await _taskService.saveTask(task, taskProvider);

      showCustomSnackBar(
        context,
        message: "Tarea agregada exitosamente",
        colorPrincipal: Colors.green.shade600,
        colorIcon: Colors.white70,
        borderColor: Colors.green,
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
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Agregar Tarea"),
      content: TaskForm(controller: _controller),
      actions: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(const Color(0xFF00BF6D)),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xFF00BF6D)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () => _saveTask(context),
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
