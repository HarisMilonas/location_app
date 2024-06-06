part of 'todo_detail_cubit.dart';

sealed class TodoDetailState extends Equatable {
  const TodoDetailState();

  @override
  List<Object> get props => [];
}

final class TodoDetailInitialState extends TodoDetailState {}

final class TodoDetailLoadingState extends TodoDetailState {}

final class TodoDetailLoadedState extends TodoDetailState {
  const TodoDetailLoadedState({required this.entryIds});

  final List<EntryId> entryIds;

  @override
  List<Object> get props => [entryIds];
}

final class TodoDetailErrorState extends TodoDetailState {}
