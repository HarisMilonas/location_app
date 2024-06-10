import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/1_domain/entitites/todo_color.dart';
import 'package:test_app/1_domain/usecases/create_todo_collection.dart';
import 'package:test_app/core/use_case.dart';

part 'create_todo_collection_page_state.dart';

class CreateToDoCollectionPageCubit
    extends Cubit<CreateTodoCollectionPageState> {
  CreateToDoCollectionPageCubit({
    required this.createToDoCollection,
  }) : super(const CreateTodoCollectionPageState());

  final CreateTodoCollection createToDoCollection;

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '') ?? 0;

    await createToDoCollection.call(ToDoCollectionParams(
      collection: TodoCollection.empty().copyWith(
        title: state.title,
        color: ToDoColor(colorIndex: parsedColorIndex),
      ),
    ));
  }
}
