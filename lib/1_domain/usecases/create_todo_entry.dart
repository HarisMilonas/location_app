import 'package:either_dart/either.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/core/use_case.dart';

class CreateTodoEntry implements UseCase<bool, ToDoEntryParams> {
  CreateTodoEntry({required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final loadedEntry = await todoRepository.createToDoEntry(
          entry: params.entry);
      return loadedEntry.fold((left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
