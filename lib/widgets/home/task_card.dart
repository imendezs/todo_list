import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/widgets/delete_task_dialog.dart';
import 'package:todo_list/widgets/update_edit_dialog.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String status;
  final Color color;
  final String createdAt;
  final String taskDate;
  final String taskId;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
    required this.color,
    required this.createdAt,
    required this.taskDate,
    required this.taskId,
  }) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de contenido principal
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Estado
                    Container(
                      constraints: BoxConstraints(minWidth: 100),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 12),
                    // Título
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              (" ${widget.title}"),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              (" ${widget.taskDate}"),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit,
                                  size: 22,
                                  color: Colors.blue.withOpacity(0.8)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return TaskEditDialog(
                                      taskId: widget.taskId,
                                      title: widget.title,
                                      description: widget.description,
                                      createdAt: widget.createdAt,
                                      taskDate: widget.taskDate,
                                      currentStatus: widget.status,
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.withOpacity(0.05)),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_rounded,
                                  size: 22, color: Colors.red.withOpacity(0.8)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteTaskDialog(
                                      taskId: widget.taskId,
                                      title: widget.title,
                                      description: widget.description,
                                      createdAt: widget.createdAt,
                                      taskDate: widget.taskDate,
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.red.withOpacity(0.05)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
