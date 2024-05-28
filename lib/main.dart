import 'package:flutter/material.dart';
import 'package:myproject/homepage.dart';
import 'package:myproject/signin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SignInApp());
}

class SignInApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => SignInPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
