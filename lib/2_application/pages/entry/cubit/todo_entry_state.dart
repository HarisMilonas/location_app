part of 'todo_entry_cubit.dart';

sealed class TodoEntryState extends Equatable {
  const TodoEntryState();

  @override
  List<Object> get props => [];
}

final class TodoEntryInitialState extends TodoEntryState {}

final class TodoEntryLoadingState extends TodoEntryState {}

final class TodoEntryLoadedState extends TodoEntryState {
  const TodoEntryLoadedState({required this.todoEntry});
  final ToDoEntry todoEntry;
}

final class TodoEntryErrorState extends TodoEntryState {}
