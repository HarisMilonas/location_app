import 'package:flutter/material.dart';
import 'package:test_app/1_domain/usecases/load_overview_todo_collection.dart';
import 'package:test_app/2_application/core/page_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/2_application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:test_app/2_application/pages/overview/view_states/todo_overview_error.dart';
import 'package:test_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:test_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoOverviewCubit(
          loadToDoCollections: LoadOverviewTodoCollection(    // calll the function that wish to be performed
              todoRepository: RepositoryProvider.of(context)))..readToDoCollections(),
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.work_history_rounded,
      name: 'overview',
      child: OverviewPageProvider());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.tealAccent,
        child: BlocBuilder<TodoOverviewCubit, TodoOverviewState>(
          builder: (context, state) {
            if (state is TodoOverviewLoadingState) {
              return const TodoOverviewLoading();
            } else if (state is TodoOverviewLoadedState) {
              return TodoOverviewLoaded(
                collections: state.collections,
              );
            } else {
              return const TodoOverviewError();
            }
          },
        ));
  }
}
