import 'package:either_dart/either.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/core/use_case.dart';

class UpdateTodoEntry implements UseCase<ToDoEntry, ToDoEntryIdsParam> {
  UpdateTodoEntry({required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdsParam params) async {
    try {
      final loadedEntry = await todoRepository.updateToDoEntry(
          collectionId: params.collectionId, entryId: params.entryId);
      return loadedEntry.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
