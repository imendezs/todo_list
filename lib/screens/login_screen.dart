import 'package:flutter/material.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/screens/logo_with_title.dart';
import 'package:todo_list/screens/register_screen.dart';
import 'package:todo_list/utils/auth.dart';
import 'package:todo_list/widgets/auth/auth_button.dart';
import 'package:todo_list/widgets/auth/auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String? correo;
  String? password;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: "Iniciar Sesión",
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
            text: "Iniciar Sesión",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print('Correo: $correo');
                print('Contraseña: $password');

                if (correo == null ||
                    correo!.isEmpty ||
                    password == null ||
                    password!.isEmpty) {
                  print("Correo o contraseña vacíos");
                  return;
                }

                var result =
                    await _auth.signInEmailAndPassword(correo!, password!);

                if (result == 1) {
                  print("Usuario no encontrado");
                } else if (result == 2) {
                  print("Contraseña incorrecta");
                } else if (result == 3) {
                  print("Error desconocido");
                } else if (result != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
              } else {
                print("El formulario no es válido");
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: Text("¿No tienes cuenta? Registrate"),
          ),
        ],
      ),
    );
  }
}
