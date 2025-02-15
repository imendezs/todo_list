import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/widgets/floating_button.dart';
import 'package:todo_list/widgets/home/add_task/add_task_dialog.dart';
import 'package:todo_list/widgets/app_bar.dart';
import 'package:todo_list/widgets/home/task_list.dart';
import 'package:todo_list/services/home/task_service.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final taskService = TaskService();
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: responsive.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(responsive.paddingMedium),
              child: Text(
                "Lista de tareas",
                style: TextStyle(
                  fontSize: responsive.textLarge,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: TaskList(
                taskStream: taskService.getUserTasks(user.uid),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: DynamicFloatingButton(
        labelText: "Agregar tarea",
        icon: Icons.task_alt_rounded,
        color: const Color(0xFF00BF6D),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
        },
      ),
    );
  }
}
