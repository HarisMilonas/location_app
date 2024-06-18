import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/1_domain/usecases/load_todo_entry_ids_for_collection.dart';
import 'package:test_app/2_application/core/page_config.dart';
import 'package:test_app/2_application/pages/details/cubit/todo_detail_cubit.dart';
import 'package:test_app/2_application/pages/details/view_states/todo_detail_error.dart';
import 'package:test_app/2_application/pages/details/view_states/todo_detail_loaded.dart';
import 'package:test_app/2_application/pages/details/view_states/todo_detail_loading.dart';



class ToDoDetailPageProvider extends StatelessWidget {
  const ToDoDetailPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoDetailCubit(
        collectionId: collectionId,
        loadToDoEntryIdsForCollection: LoadTodoEntryIdsForCollection(
            todoRepository: RepositoryProvider.of<TodoRepository>(context)),
      )..fetch(),
      child: TodoDetailPage(collectionId: collectionId),
    );
  }
}

class TodoDetailPage extends StatelessWidget {
  const TodoDetailPage({super.key, required this.collectionId});

  final CollectionId collectionId;

  static const pageConfig = PageConfig(
      icon: Icons.details_outlined, name: 'detail', child: Placeholder());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailCubit, TodoDetailState>(
      builder: (context, state) {
        if (state is TodoDetailLoadingState) {
          return const TodoDetailLoading();
        } else if (state is TodoDetailLoadedState) {
          return TodoDetailLoaded(
              collectionId: collectionId, entryIds: state.entryIds);
        } else {
          return const TodoDetailError();
        }
      },
    );
  }
}
