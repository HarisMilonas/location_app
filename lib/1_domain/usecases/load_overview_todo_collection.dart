import 'package:either_dart/either.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/core/use_case.dart';

class LoadOverviewTodoCollection implements UseCase<List<TodoCollection>, NoParams> {
  const LoadOverviewTodoCollection({required this.todoRepository});

  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, List<TodoCollection>>> call(NoParams params) async {
    try {
      final loadedCollections = await todoRepository.readToDoCollections();
      return loadedCollections.fold(
          (left) => Left(left), (right) => Right(right));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
