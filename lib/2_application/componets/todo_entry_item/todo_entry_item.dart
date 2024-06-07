import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/1_domain/usecases/load_todo_entry.dart';
import 'package:test_app/1_domain/usecases/update_todo_entry.dart';
import 'package:test_app/2_application/componets/todo_entry_item/cubit/todo_entry_cubit.dart';
import 'package:test_app/2_application/componets/todo_entry_item/view_startes/todo_entry_error.dart';
import 'package:test_app/2_application/componets/todo_entry_item/view_startes/todo_entry_loaded.dart';
import 'package:test_app/2_application/componets/todo_entry_item/view_startes/todo_entry_loading.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  const ToDoEntryItemProvider(
      {super.key, required this.collectionId, required this.entryId});

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryCubit>(
      create: (context) => TodoEntryCubit(
        collectionId: collectionId,
        entryId: entryId,
        loadTodoEntry: LoadTodoEntry(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        ),
        uploadToDoEntry: UpdateTodoEntry(todoRepository: RepositoryProvider.of<TodoRepository>(context))
      )..fetch(),
      child: const TodoEntryItem(),
    );
  }
}

class TodoEntryItem extends StatelessWidget {
  const TodoEntryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEntryCubit, TodoEntryState>(
      builder: (context, state) {
        if (state is TodoEntryLoadingState) {
          return const TodoEntryLoading();
        } else if (state is TodoEntryLoadedState) {
          return TodoEntryLoaded(
            entryItem: state.toDoEntry,
            onChanged: (value) => context.read<TodoEntryCubit>().update(),
            );
        } else {
          return const TodoEntryError();
        }
      },
    );
  }
}
