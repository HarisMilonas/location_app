
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/2_application/core/routes.dart';


class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      title: 'ToDo App',
      localizationsDelegates:   const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.light),),
      darkTheme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      routerConfig: routes,
    );
  }
} 