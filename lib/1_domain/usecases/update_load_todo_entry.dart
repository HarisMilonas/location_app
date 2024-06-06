import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/core/use_case.dart';

class UpdateLoadTodoEntry implements UseCase<ToDoEntry, UpdateToDoEntryParam> {
  const UpdateLoadTodoEntry({required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(UpdateToDoEntryParam params) async {
    try {
      final loadedEntry =
          todoRepository.updateToDoEntry(params.collectionId, params.entry);
      return loadedEntry.fold((left) => Left(left), (right) => Right(right));
    } catch (e) {
      debugPrint(e.toString());
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}