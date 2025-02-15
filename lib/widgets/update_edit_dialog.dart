import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/update_task_status_provider.dart';
import 'package:todo_list/services/update_task_service.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class TaskEditDialog extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final String createdAt;
  final String taskDate;
  final String currentStatus;

  TaskEditDialog({
    required this.taskId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.taskDate,
    required this.currentStatus,
  });

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
    final taskProvider = Provider.of<UpdateTaskStatusProvider>(context);
    final responsive = ResponsiveHelper(context);

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.borderRadiusMedium)),
      child: Padding(
        padding: EdgeInsets.all(responsive.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Cambiar estado",
              style: TextStyle(
                fontSize: responsive.textMedium,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: responsive.spacingMedium),
            Container(
              padding: EdgeInsets.all(responsive.paddingMedium),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(responsive.borderRadiusMedium),
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
                            fontSize: responsive.textMedium,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(width: responsive.spacingSmall),
                      Expanded(
                        child: Text(
                          widget.taskDate,
                          style: TextStyle(
                            fontSize: responsive.textSmall,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.spacingSmall),
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: responsive.textSmall,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.spacingSmall),
            _buildStatusRadio("Pendiente", selectedStatus, (value) {
              setState(() {
                selectedStatus = value!;
              });
            }, responsive),
            _buildStatusRadio("Completada", selectedStatus, (value) {
              setState(() {
                selectedStatus = value!;
              });
            }, responsive),
            SizedBox(height: responsive.spacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    padding:
                        EdgeInsets.symmetric(horizontal: responsive.paddingMedium, vertical: responsive.paddingSmall),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.borderRadiusSmall)),
                  ),
                  child: Text("Cancelar", style: TextStyle(fontSize: responsive.textSmall)),
                ),
                TextButton(
                  onPressed: taskProvider.isButtonDisabled
                      ? null
                      : () async {
                          if (selectedStatus != widget.currentStatus) {
                            taskProvider.setButtonDisabled(true);

                            try {
                              await UpdateTaskService().updateTaskStatus(widget.taskId, selectedStatus);
                            } catch (e) {
                              print("Error updating status: $e");
                            }

                            taskProvider.setButtonDisabled(false);
                          }
                          Navigator.pop(context);
                        },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade600,
                    padding:
                        EdgeInsets.symmetric(horizontal: responsive.paddingMedium, vertical: responsive.paddingSmall),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.borderRadiusSmall)),
                  ),
                  child: taskProvider.isButtonDisabled
                      ? SizedBox(
                          width: responsive.iconSmall,
                          height: responsive.iconSmall,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text("Guardar", style: TextStyle(fontSize: responsive.textSmall)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRadio(
      String value, String groupValue, ValueChanged<String?> onChanged, ResponsiveHelper responsive) {
    return RadioListTile<String>(
      title: Text(value, style: TextStyle(fontSize: responsive.textMedium)),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: Colors.blue.shade600,
    );
  }
}
