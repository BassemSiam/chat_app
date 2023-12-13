import 'package:chat_app/Screens/Login_screen.dart';
import 'package:chat_app/Screens/Register_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'RegisterScreen' : (context) => RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home:LoginScreen(),
    );
  }
}

