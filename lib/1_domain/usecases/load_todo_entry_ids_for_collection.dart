import 'package:either_dart/either.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/core/use_case.dart';

class LoadTodoEntryIdsForCollection
    implements UseCase<List<EntryId>, CollectionIdParam> {
  @override
  const LoadTodoEntryIdsForCollection({required this.todoRepository});
  final TodoRepository todoRepository;

  @override
  Future<Either<Failure, List<EntryId>>> call(CollectionIdParam params) async {
    try {
      final loadedIds = todoRepository.readToDoEntryIds(
        params.collectionId,
      );

      return loadedIds.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
