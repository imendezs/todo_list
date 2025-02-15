import 'package:flutter/material.dart';

class TaskFormController {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedStatus = "Pendiente";

  void dispose() {
    dateController.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}
