import 'package:flutter/material.dart';

class TodoEntryLoading extends StatelessWidget {
  const TodoEntryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}