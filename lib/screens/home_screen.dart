import 'package:flutter/material.dart';
import 'package:todo_list/screens/logo_with_title.dart';
import 'package:todo_list/screens/register_screen.dart';
import 'package:todo_list/widgets/auth/auth_button.dart';
import 'package:todo_list/widgets/auth/auth_text_field.dart';

class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Hola a todos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
