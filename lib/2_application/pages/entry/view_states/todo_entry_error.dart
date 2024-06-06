import 'package:flutter/material.dart';

class ToDoEntryError extends StatelessWidget {
  const ToDoEntryError({super.key});

 @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('Error on Entry Page, please try again'),
    );
  }
}