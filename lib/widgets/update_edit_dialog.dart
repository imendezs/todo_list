import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/update.dart';
import 'package:todo_list/services/update_service.dart';

class TaskEditDialog extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final String createdAt;
  final String taskDate;
  final String currentStatus;

  TaskEditDialog(
      {required this.taskId,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.taskDate,
      required this.currentStatus});

  @override
  _TaskEditDialogState createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  late String selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Cambiar estado", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Column(
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.taskDate,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                overflow: TextOverflow.ellipsis,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _buildStatusRadio(context, "Pendiente", selectedStatus, (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                }),
                _buildStatusRadio(context, "Completada", selectedStatus, (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                }),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedStatus != widget.currentStatus) {
                      try {
                        await UpdateService().updateTaskStatus(widget.taskId, selectedStatus);
                      } catch (e) {
                        print("Error updating status: $e");
                      }
                    } else {
                      print("No changes to update.");
                    }
                    Navigator.pop(context);
                  },
                  child: Text("Guardar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRadio(BuildContext context, String value, String groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      title: Text(value),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Theme.of(context).primaryColor,
    );
  }
}
