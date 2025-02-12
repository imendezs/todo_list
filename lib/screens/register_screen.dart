import 'package:flutter/material.dart';
import 'package:todo_list/screens/logo_with_title.dart';
import 'package:todo_list/utils/auth.dart';
import 'package:todo_list/widgets/auth/auth_button.dart';
import 'package:todo_list/widgets/auth/auth_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String? correo;
  String? password;

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: "Registrar",
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                  hintText: "Correo",
                  onSaved: (value) => correo = value,
                ),
                AuthTextField(
                  hintText: "Contraseña",
                  obscureText: true,
                  onSaved: (value) => password = value,
                ),
              ],
            ),
          ),
          AuthButton(
            text: "Registrar",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (correo != null && password != null) {
                  var result = await _auth.createAcount(correo!, password!);
                  print("Resultado: $result");
                } else {
                  print("Correo o contraseña son nulos");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
