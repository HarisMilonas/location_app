part of 'create_todo_entry_page_cubit.dart';

class CreateTodoEntryPageState extends Equatable {
  const CreateTodoEntryPageState({this.description});

  final FormValue<String?>? description;

  CreateTodoEntryPageState copyWith({FormValue<String?>? description}) {
    return CreateTodoEntryPageState(
        description: description ?? this.description);
  }

  @override
  List<Object?> get props => [description];
}
