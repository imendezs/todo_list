import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/delete_task_provider.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class DeleteTaskDialog extends StatelessWidget {
  final String taskId;
  final String title;
  final String description;
  final String createdAt;
  final String taskDate;

  DeleteTaskDialog({
    required this.taskId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.taskDate,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<DeleteTaskProvider>(context);
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
              "Eliminar Tarea",
              style: TextStyle(
                fontSize: responsive.textMedium,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: responsive.spacingSmall),
            Text(
              "¿Estás seguro de eliminar la tarea?",
              style: TextStyle(
                fontSize: responsive.textSmall,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: responsive.spacingLarge),
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
                          title,
                          style: TextStyle(
                            fontSize: responsive.textMedium,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(width: responsive.spacingMedium),
                      Expanded(
                        child: Text(
                          taskDate,
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
                    description,
                    style: TextStyle(
                      fontSize: responsive.textSmall,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.spacingLarge),
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
                          await taskProvider.deleteTask(taskId, context);
                          Navigator.pop(context);
                        },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red.shade600,
                    padding:
                        EdgeInsets.symmetric(horizontal: responsive.paddingMedium, vertical: responsive.paddingSmall),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(responsive.borderRadiusSmall)),
                  ),
                  child: taskProvider.isButtonDisabled
                      ? CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text("Eliminar", style: TextStyle(fontSize: responsive.textSmall)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
