import 'package:flutter/material.dart';
import 'package:todo_list/widgets/delete_task_dialog.dart';
import 'package:todo_list/widgets/responsive_helper.dart';
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
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsive.spacingSmall,
        horizontal: responsive.spacingMedium,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(responsive.borderRadiusMedium),
        ),
        child: Padding(
          padding: EdgeInsets.all(responsive.paddingMedium),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: responsive.containerWidthSmall),
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.paddingMedium,
                        vertical: responsive.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(responsive.borderRadiusSmall),
                      ),
                      child: Text(
                        widget.status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.textSmall,
                        ),
                      ),
                    ),
                    SizedBox(height: responsive.spacingMedium),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: responsive.textMedium * 0.9,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: responsive.spacingSmall),
                              Text(
                                widget.taskDate,
                                style: TextStyle(
                                  fontSize: responsive.textSmall,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: responsive.spacingSmall),
                        Row(
                          children: [
                            _buildIconButton(
                              icon: Icons.edit,
                              color: Colors.blue,
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
                              responsive: responsive,
                            ),
                            SizedBox(width: responsive.spacingSmall),
                            _buildIconButton(
                              icon: Icons.delete_rounded,
                              color: Colors.red,
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
                              responsive: responsive,
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

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required ResponsiveHelper responsive,
  }) {
    return IconButton(
      icon: Icon(
        icon,
        size: responsive.iconSmall * 1.2,
        color: color.withOpacity(0.8),
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color.withOpacity(0.05)),
      ),
    );
  }
}
