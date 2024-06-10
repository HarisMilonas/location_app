part of 'create_todo_collection_page_cubit.dart';

class CreateTodoCollectionPageState extends Equatable {
  const CreateTodoCollectionPageState({this.title, this.color});

  final String? title;
  final String? color;

  CreateTodoCollectionPageState copyWith({String? title, String? color}) {
    return CreateTodoCollectionPageState(
        color: color ?? this.color, title: title ?? this.title);
  }

  @override
  List<Object?> get props => [title, color];
}

final class CreateTodoCollectionPageInitialState
    extends CreateTodoCollectionPageState {
  const CreateTodoCollectionPageInitialState();
}

final class CreateTodoCollectionPageLoadingState
    extends CreateTodoCollectionPageState {
  const CreateTodoCollectionPageLoadingState();
}

final class CreateTodoCollectionPageLoadedState
    extends CreateTodoCollectionPageState {
  const CreateTodoCollectionPageLoadedState();
}

final class CreateTodoCollectionPageErrorState
    extends CreateTodoCollectionPageState {
  const CreateTodoCollectionPageErrorState();
}
