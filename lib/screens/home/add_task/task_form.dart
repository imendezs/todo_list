import 'package:flutter/material.dart';
import 'package:todo_list/widgets/home/add_task/task_form_controller.dart';

class TaskForm extends StatefulWidget {
  final TaskFormController controller;

  const TaskForm({super.key, required this.controller});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDateField(context),
          const SizedBox(height: 10),
          _buildTextField(widget.controller.titleController, "Título"),
          const SizedBox(height: 10),
          _buildTextField(widget.controller.descriptionController, "Descripción", maxLines: 3),
          const SizedBox(height: 10),
          _buildStatusSelector(),
        ],
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return TextField(
      controller: widget.controller.dateController,
      decoration: const InputDecoration(
        labelText: "Fecha",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF00BF6D),
                  onPrimary: Colors.white,
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          setState(() {
            widget.controller.dateController.text = pickedDate.toLocal().toString().split(' ')[0];
          });
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      maxLines: maxLines,
    );
  }

  Widget _buildStatusSelector() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF00BF6D),
            title: const Text("Pendiente"),
            value: "Pendiente",
            groupValue: widget.controller.selectedStatus,
            onChanged: (value) {
              setState(() {
                widget.controller.selectedStatus = value as String;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF00BF6D),
            title: const Text("Completada"),
            value: "Completada",
            groupValue: widget.controller.selectedStatus,
            onChanged: (value) {
              setState(() {
                widget.controller.selectedStatus = value as String;
              });
            },
          ),
        ),
      ],
    );
  }
}
