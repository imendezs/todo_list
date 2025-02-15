import 'package:flutter/material.dart';
import 'package:todo_list/screens/home/home_screen.dart';
import 'package:todo_list/widgets/logo_with_title.dart';
import 'package:todo_list/screens/login/register_screen.dart';
import 'package:todo_list/services/login/auth_login.dart';
import 'package:todo_list/widgets/login/login_button.dart';
import 'package:todo_list/widgets/login/login_text_field.dart';
import 'package:todo_list/widgets/responsive_helper.dart';
import 'package:todo_list/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthLogin _auth = AuthLogin();
  String? correo;
  String? password;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: "To-Do List",
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                LoginTextField(
                  hintText: "Correo",
                  onSaved: (value) => correo = value,
                ),
                LoginTextField(
                  hintText: "Contraseña",
                  obscureText: true,
                  onSaved: (value) => password = value,
                ),
              ],
            ),
          ),
          SizedBox(height: responsive.spacingMedium),
          LoginButton(
            text: "Iniciar Sesión",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (correo == null || correo!.isEmpty || password == null || password!.isEmpty) {
                  showCustomSnackBar(
                    context,
                    message: 'Por favor ingresa correo y contraseña',
                    colorPrincipal: Colors.amber.shade600,
                    colorIcon: Colors.white70,
                    borderColor: Colors.amber,
                    icon: Icons.warning,
                  );
                  return;
                }

                var result = await _auth.signInEmailAndPassword(correo!, password!);

                if (result == 1 || result == 2 || result == 3 || result == 4) {
                  showCustomSnackBar(
                    context,
                    message: 'Usuario o contraseña incorrectos',
                    colorPrincipal: Colors.redAccent,
                    colorIcon: Colors.white70,
                    borderColor: Colors.redAccent,
                    icon: Icons.error,
                  );
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
          SizedBox(height: responsive.containerHeightSmall),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FutureBuilder(
                      future: Future.delayed(Duration(milliseconds: 600)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Container(color: Colors.white);
                        }
                        return RegisterScreen();
                      },
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Text.rich(
              TextSpan(
                text: "¿No tienes cuenta? ",
                style: TextStyle(color: Colors.black45, fontSize: responsive.textSmall),
                children: [
                  TextSpan(
                    text: "Regístrate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00BF6D),
                      fontSize: responsive.textSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
