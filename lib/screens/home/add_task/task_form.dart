import 'package:flutter/material.dart';
import 'package:todo_list/utils/home/task_form_controller.dart';
import 'package:todo_list/widgets/responsive_helper.dart';

class TaskForm extends StatefulWidget {
  final TaskFormController controller;

  const TaskForm({super.key, required this.controller});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);
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
        labelStyle: TextStyle(color: Colors.black54),
        suffixIcon: Icon(Icons.calendar_month),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00BF6D), width: 2),
        ),
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
      cursorColor: Color(0xFF00BF6D),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black54),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00BF6D), width: 2),
        ),
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildStatusSelector() {
    final responsive = ResponsiveHelper(context);
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF00BF6D),
            title: Text("Pendiente", style: TextStyle(fontSize: responsive.textSmall)),
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
            title: Text("Completada", style: TextStyle(fontSize: responsive.textSmall)),
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
