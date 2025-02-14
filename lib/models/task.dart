import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String title;
  final String description;
  final String status;
  final DateTime date;
  final String userId;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'status': status,
      'date': date,
      'userId': userId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
