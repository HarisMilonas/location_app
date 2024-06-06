part of 'todo_overview_cubit.dart';

sealed class TodoOverviewState extends Equatable {
  const TodoOverviewState();

  @override
  List<Object> get props => [];
}

final class TodoOverviewInitial extends TodoOverviewState {}

class TodoOverviewLoadingState extends TodoOverviewState {
  const TodoOverviewLoadingState();
}

class TodoOverviewLoadedState extends TodoOverviewState {
  const TodoOverviewLoadedState({required this.collections});
  final List<TodoCollection> collections;
}

class TodoOverviewErrorState extends TodoOverviewState {
  const TodoOverviewErrorState();
}
