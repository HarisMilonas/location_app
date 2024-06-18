import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/usecases/create_todo_entry.dart';
import 'package:test_app/2_application/core/form_value.dart';
import 'package:test_app/core/use_case.dart';

part 'create_todo_entry_page_state.dart';

class CreateTodoEntryPageCubit extends Cubit<CreateTodoEntryPageState> {
  CreateTodoEntryPageCubit(
      {required this.collectionId, required this.addTodoEntry})
      : super(const CreateTodoEntryPageState());

  final CollectionId collectionId;
  final CreateTodoEntry addTodoEntry;
   
  void descriptionChanged({String? description}) {
     print('i am here');
    ValidationStatus currentStatus = ValidationStatus.pending;
    // could do more complex validation, like calling your backend and so on
    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }
    emit(
      state.copyWith(
        description: FormValue(
          value: description,
          validationStatus: currentStatus,
        ),
      ),
    );
  }

  void submit() async {
    await addTodoEntry.call(
      ToDoEntryParams(
        entry: ToDoEntry.empty().copyWith(
          description: state.description?.value,
        ),
      ),
    );
  }
}
