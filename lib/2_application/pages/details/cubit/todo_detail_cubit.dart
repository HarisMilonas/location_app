import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/usecases/load_todo_entry_ids_for_collection.dart';
import 'package:test_app/core/use_case.dart';

part 'todo_detail_state.dart';

class TodoDetailCubit extends Cubit<TodoDetailState> {
  TodoDetailCubit(
      {required this.collectionId, required this.loadToDoEntryIdsForCollection})
      : super(TodoDetailLoadingState());

  final CollectionId collectionId;
  final LoadTodoEntryIdsForCollection loadToDoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(TodoDetailLoadingState());
    try {
      final entryIds = await loadToDoEntryIdsForCollection.call(
        CollectionIdParam(collectionId: collectionId),
      );
      if (entryIds.isLeft) {
        emit(TodoDetailErrorState());
      } else {
        emit(TodoDetailLoadedState(entryIds: entryIds.right));
      }
    } on Exception {
      emit(TodoDetailErrorState());
    }
  }


}
