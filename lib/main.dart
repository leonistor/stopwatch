import 'package:flutter/material.dart';
import 'package:stopwatch/login_screen.dart';
import 'package:stopwatch/stopwatch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        StopWatch.route: (context) =>
            const StopWatch(name: 'Unknown', email: ''),
      },
      initialRoute: '/',
    );
  }
}
