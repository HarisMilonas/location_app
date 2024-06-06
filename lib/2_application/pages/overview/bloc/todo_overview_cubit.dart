import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/usecases/load_overview_todo_collection.dart';
import 'package:test_app/core/use_case.dart';

part 'todo_overview_state.dart';

class TodoOverviewCubit extends Cubit<TodoOverviewState> {
  TodoOverviewCubit({
    required this.loadToDoCollections,
    TodoOverviewState? initialState,
  }) : super(initialState ?? const TodoOverviewLoadingState());

  final LoadOverviewTodoCollection loadToDoCollections;

  Future<void> readToDoCollections() async {
    emit(const TodoOverviewLoadingState());
    try {
      final collectionsFuture = loadToDoCollections.call(NoParams());
      final collections = await collectionsFuture;

      if (collections.isLeft) {
        emit(const TodoOverviewErrorState());
      } else {
        emit(TodoOverviewLoadedState(collections: collections.right));
      }
    } on Exception {
      emit(const TodoOverviewErrorState());
    }
  }
}
