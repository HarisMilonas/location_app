import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/usecases/load_todo_entry.dart';
import 'package:test_app/1_domain/usecases/update_todo_entry.dart';
import 'package:test_app/core/use_case.dart';

part 'todo_entry_state.dart';

class TodoEntryCubit extends Cubit<TodoEntryState> {
  TodoEntryCubit(
      {required this.entryId,
      required this.collectionId,
      required this.loadTodoEntry,
      required this.uploadToDoEntry})
      : super(TodoEntryLoadingState());

  final EntryId entryId;
  final CollectionId collectionId;
  final LoadTodoEntry loadTodoEntry;
  final UpdateTodoEntry uploadToDoEntry;

  Future<void> fetch() async {
    try {
      
      final entry = await loadTodoEntry.call(
          ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId));
      entry.fold(
        (left) => emit(TodoEntryErrorState()),
        (right) => emit(TodoEntryLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(TodoEntryErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await uploadToDoEntry.call(
          ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId));
      updatedEntry.fold(
        (left) => emit(TodoEntryErrorState()),
        (right) => emit(
          TodoEntryLoadedState(toDoEntry: right),
        ),
      );
    } on Exception {
      emit(TodoEntryErrorState());
    }
  }
}
