import 'package:flutter/material.dart';

class Update extends ChangeNotifier {
  String _taskStatus = "Pendiente";

  String get taskStatus => _taskStatus;

  void setTaskStatus(String status) {
    _taskStatus = status;
    notifyListeners();
  }
}
