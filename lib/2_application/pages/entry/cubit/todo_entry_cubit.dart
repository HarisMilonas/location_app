import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/usecases/load_todo_entry.dart';
import 'package:test_app/1_domain/usecases/update_load_todo_entry.dart';
import 'package:test_app/core/use_case.dart';

part 'todo_entry_state.dart';

class TodoEntryCubit extends Cubit<TodoEntryState> {
  TodoEntryCubit(
      {required this.entryId,
      required this.loadTodoEntry,
      required this.updateLoadTodoEntry,
      required this.collectionId})
      : super(TodoEntryLoadingState());

  final EntryId entryId;
  final CollectionId collectionId;
  LoadTodoEntry loadTodoEntry;
  UpdateLoadTodoEntry updateLoadTodoEntry;

  Future<void> fetchEntry() async {
    emit(TodoEntryLoadingState());
    try {
      final todoEntry = await loadTodoEntry.call(
          ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId));

      if (todoEntry.isLeft) {
        emit(TodoEntryErrorState());
      } else {
        emit(TodoEntryLoadedState(todoEntry: todoEntry.right));
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      emit(TodoEntryErrorState());
    }
  }

  Future<void> updateEntry(ToDoEntry todoEntry) async {
    emit(TodoEntryLoadingState());
    try {
      final ToDoEntry updated = ToDoEntry(
          id: todoEntry.id,
          description: todoEntry.description,
          isDone: !todoEntry.isDone);

      final updatedTodoEntry = await updateLoadTodoEntry.call(
          UpdateToDoEntryParam(collectionId: collectionId, entry: updated));
      if (updatedTodoEntry.isLeft) {
        emit(TodoEntryErrorState());
      } else {
        emit(TodoEntryLoadedState(todoEntry: updatedTodoEntry.right));
      }
    } on Exception {
      emit(TodoEntryErrorState());
    }
  }
}
