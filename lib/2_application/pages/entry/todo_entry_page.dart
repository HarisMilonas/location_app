import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/1_domain/usecases/load_todo_entry.dart';
import 'package:test_app/1_domain/usecases/update_load_todo_entry.dart';
import 'package:test_app/2_application/core/page_config.dart';
import 'package:test_app/2_application/pages/entry/cubit/todo_entry_cubit.dart';
import 'package:test_app/2_application/pages/entry/view_states/todo_entry_error.dart';
import 'package:test_app/2_application/pages/entry/view_states/todo_entry_loaded.dart';
import 'package:test_app/2_application/pages/entry/view_states/todo_entry_loading.dart';

class TodoEntryPageProvider extends StatelessWidget {
  const TodoEntryPageProvider(
      {super.key, required this.collectionId, required this.entryId});

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoEntryCubit(
          collectionId: collectionId,
          entryId: entryId,
          loadTodoEntry: LoadTodoEntry(
              todoRepository:
               RepositoryProvider.of<TodoRepository>(context)),
                updateLoadTodoEntry:UpdateLoadTodoEntry(todoRepository: RepositoryProvider.of<TodoRepository>(context)) 
                )..fetchEntry(),
      child: const TodoEntryPage(),
    );
  }
}

class TodoEntryPage extends StatelessWidget {
  const TodoEntryPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.access_alarm_rounded, name: 'entry', child: TodoEntryPage());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryCubit, TodoEntryState>(
      builder: (context, state) {
        if (state is TodoEntryLoadingState) {
          return const TodoEntryLoading();
        } else if (state is TodoEntryLoadedState) {
          return TodoEntryLoaded(toDoEntry: state.todoEntry);
        } else {
          return const ToDoEntryError();
        }
      },
    );
  }
}
