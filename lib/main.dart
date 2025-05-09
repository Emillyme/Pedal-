import 'package:flutter/material.dart';
import 'package:pedal_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pedal_project/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PEDAL+',
      theme:ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
          ),
        ),
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}