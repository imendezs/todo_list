import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/home/task_card.dart';

class TaskList extends StatelessWidget {
  final Stream<QuerySnapshot> taskStream;

  const TaskList({super.key, required this.taskStream});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: taskStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Color(0xFF00BF6D),
                    color: Colors.white60,
                  ));
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Error al cargar las tareas."));
                }

                final tasks = snapshot.data?.docs ?? [];

                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/noData.png',
                          width: 250,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Tu lista de tareas está vacía.",
                          style: TextStyle(fontSize: 23, color: Colors.black12, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index].data() as Map<String, dynamic>;

                    String formattedCreatedAt = _formatTimestamp(task['createdAt']);
                    String formattedDate = _formatTimestamp(task['date']);

                    return TaskCard(
                      title: task['title'],
                      description: task['description'],
                      status: task['status'],
                      color: task['status'] == 'Completada' ? Color(0xFF00BF6D) : Colors.amber,
                      createdAt: formattedCreatedAt,
                      taskDate: formattedDate,
                      taskId: tasks[index].id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "Fecha no disponible";
    DateTime date = timestamp.toDate();
    return DateFormat('dd MMMM yyyy', 'es_ES').format(date);
  }
}
