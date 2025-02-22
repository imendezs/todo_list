import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/providers/delete_task_provider.dart';
import 'package:todo_list/providers/add_task_provider.dart';
import 'package:todo_list/providers/update_task_status_provider.dart';
import 'package:todo_list/screens/login/login_screen.dart';
import 'package:todo_list/services/traslation_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('es_ES', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => TranslationService()),
        ChangeNotifierProvider(
          create: (context) => AddTaskProvider(
            translationService: Provider.of<TranslationService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(create: (_) => UpdateTaskStatusProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo Task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: _handleAuth(),
      ),
    );
  }

  Widget _handleAuth() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return const HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
