import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoParams extends Params {
  @override
  List<Object?> get props => [];
}

class ToDoEntryIdsParam extends Params {
  ToDoEntryIdsParam({required this.collectionId, required this.entryId})
      : super();
  final EntryId entryId;
  final CollectionId collectionId;

  @override
  List<Object> get props => [entryId, collectionId];
}

class CollectionIdParam extends Params {
  CollectionIdParam({
    required this.collectionId,
  }) : super();

  final CollectionId collectionId;

  @override
  List<Object> get props => [collectionId];
}

class ToDoCollectionParams extends Params {
  ToDoCollectionParams({
    required this.collection,
  }) : super();

  final TodoCollection collection;

  @override
  List<Object> get props => [collection];
}



class ToDoEntryParams extends Params {
  ToDoEntryParams({
    required this.entry,
  }) : super();

  final ToDoEntry entry;

  @override
  List<Object> get props => [entry];
}