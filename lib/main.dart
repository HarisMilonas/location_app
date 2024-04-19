import 'package:flutter/material.dart';
import 'package:test_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 245, 245, 220)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 140, 204, 142),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor:Color.fromARGB(255, 251, 251, 183) ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test 1'),
    );
  }
}
