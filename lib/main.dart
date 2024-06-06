import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/0_data/repository/todo_repository_mock.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/2_application/app/basic_app.dart';

void main() {
  runApp(RepositoryProvider<TodoRepository>(
    create: (context) => TodoRepositoryMock(),
    child: const BasicApp(),
  ));
}
