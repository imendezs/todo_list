import 'package:flutter/material.dart';
import 'package:todo_list/screens/home/home_screen.dart';
import 'package:todo_list/screens/login/login_screen.dart';
import 'package:todo_list/widgets/logo_with_title.dart';
import 'package:todo_list/services/login/auth.dart';
import 'package:todo_list/widgets/login/button.dart';
import 'package:todo_list/widgets/login/text_field.dart';
import 'package:todo_list/widgets/snackbar.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final AuthLogin _auth = AuthLogin();

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

                var result = await _auth.createAcount(correo ?? "", password ?? "");

                if (result == 1) {
                  showCustomSnackBar(
                    context,
                    message: "La contraseña es muy débil",
                    colorPrincipal: Colors.amber.shade600,
                    colorIcon: Colors.white70,
                    borderColor: Colors.amber,
                    icon: Icons.warning,
                  );
                } else if (result == 2) {
                  showCustomSnackBar(
                    context,
                    message: "Este correo ya está registrado",
                    colorPrincipal: Colors.redAccent,
                    colorIcon: Colors.white60,
                    borderColor: Colors.redAccent,
                    icon: Icons.error,
                  );
                } else if (result != null) {
                  showCustomSnackBar(
                    context,
                    message: "Registro exitoso. Puede iniciar sesión para acceder a su cuenta.",
                    colorPrincipal: Colors.green.shade600,
                    colorIcon: Colors.white70,
                    borderColor: Colors.green,
                    icon: Icons.check_circle,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  showCustomSnackBar(
                    context,
                    message: "Error desconocido al registrar usuario",
                    colorPrincipal: Colors.grey.shade600,
                    colorIcon: Colors.white70,
                    borderColor: Colors.grey,
                    icon: Icons.error_outline,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
