import 'package:either_dart/either.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/entitites/todo_color.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';

class TodoRepositoryMock implements TodoRepository {
  final List<ToDoEntry> todoEntries = List.generate(
    100,
    (index) => ToDoEntry(
      id: EntryId.fromUniqueString(index.toString()),
      description: 'description $index',
      isDone: false,
    ),
  );

  final toDoCollections = List<TodoCollection>.generate(
    10,
    (index) => TodoCollection(
      id: CollectionId.fromUniqueString(index.toString()),
      title: 'title $index',
      color: ToDoColor(
        colorIndex: index % ToDoColor.predefinedColors.length,
      ),
    ),
  );

  @override
  Future<Either<Failure, List<TodoCollection>>> readToDoCollections() {
    try {
      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(toDoCollections),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final selectedEntryItem = todoEntries.firstWhere(
        (element) => element.id == entryId,
      );

      return Future.delayed(
        const Duration(milliseconds: 200),
        () => Right(selectedEntryItem),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionid) {
    try {
      final startIndex = int.parse(collectionid.value) * 10;
      final endIndex = startIndex + 10;
      final entryIds = todoEntries
          .sublist(startIndex, endIndex)
          .map((entry) => entry.id)
          .toList();

      return Future.delayed(
        const Duration(milliseconds: 300),
        () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      CollectionId collectionId, ToDoEntry entry) {
    try {
      todoEntries.removeWhere((item) => item.id == entry.id);

      todoEntries.add(entry);

      return Future.delayed(
        const Duration(milliseconds: 300),
        () => Right(entry),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
