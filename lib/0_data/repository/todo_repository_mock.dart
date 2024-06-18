import 'package:either_dart/either.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/entitites/todo_color.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';



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

class TodoRepositoryMock implements TodoRepository {
  final List<ToDoEntry> todoEntries = List.generate(
    100,
    (index) => ToDoEntry(
      id: EntryId.fromUniqueString(index.toString()),
      description: 'description $index',
      isDone: false,
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
      int endIndex = startIndex + 10;
      if (todoEntries.length < endIndex) {
        endIndex = todoEntries.length;
      }
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
      {required CollectionId collectionId, required EntryId entryId}) {
    try {
      final index = todoEntries.indexWhere((element) => element.id == entryId);
      final entryToUpdate = todoEntries[index];
      final updatedEntry =
          todoEntries[index].copyWith(isDone: !entryToUpdate.isDone);
      todoEntries[index] = updatedEntry;

      return Future.delayed(
          const Duration(seconds: 1), () => Right(updatedEntry));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      {required TodoCollection collection}) {
    final collectionToAdd = TodoCollection(
        id: CollectionId.fromUniqueString(toDoCollections.length.toString()),
        title: collection.title,
        color: collection.color);
    try {
      toDoCollections.add(collectionToAdd);

      return Future.delayed(
          const Duration(milliseconds: 100), () => const Right(true));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry({required ToDoEntry entry}) {
    try {
      todoEntries.add(entry);
      return Future.value(const Right(true));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
