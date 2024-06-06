import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_app/0_data/repository/todo_repository_mock.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/failures/failures.dart';
import 'package:test_app/1_domain/usecases/load_overview_todo_collection.dart';
import 'package:test_app/core/use_case.dart';

import 'todo_overview_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoRepositoryMock>()])
void main() {
  provideDummy<Either<Failure, List<TodoCollection>>>(
      Right(<TodoCollection>[TodoCollection.empty()]));
  group('LoadOverviewToDo Usecases', () {
    test('should return ToDos collections', () async {
      final mockToDorepoImpl = MockTodoRepositoryMock();

      final todoPreviewCollections =
          LoadOverviewTodoCollection(todoRepository: mockToDorepoImpl);

      when(mockToDorepoImpl.readToDoCollections()).thenAnswer(
          (realInvocation) =>
              Future.value(Right(<TodoCollection>[TodoCollection.empty()])));

      final result = await todoPreviewCollections.call(NoParams());

      expect(result.isLeft, false);
      expect(result.isRight, true);
      expect(
          result,
          Right<Failure, List<TodoCollection>>(
              <TodoCollection>[TodoCollection.empty()]));
      verify(mockToDorepoImpl.readToDoCollections()).called(1);
      verifyNoMoreInteractions(mockToDorepoImpl);
    });
  });
}
