import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:test_app/2_application/pages/details/todo_detail_page.dart';
import 'package:test_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:test_app/2_application/pages/overview/bloc/todo_overview_cubit.dart';

class TodoOverviewLoaded extends StatelessWidget {
  const TodoOverviewLoaded({super.key, required this.collections});

  final List<TodoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final item = collections[index];
            final colorScheme = Theme.of(context).colorScheme;

            return BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
              //dont rebuild when we are clicking the same item nothing will change(to improve perfomance!)
              buildWhen: (previous, current) =>
                  previous.selectedCollectionId != current.selectedCollectionId,
              builder: (context, state) {
                debugPrint('build the item ${item.id.value}');
                return ListTile(
                  tileColor: colorScheme.surface,
                  selectedTileColor: colorScheme.onSurfaceVariant,
                  iconColor: item.color.color,
                  selectedColor: item.color.color,
                  selected: state.selectedCollectionId == item.id,
                  onTap: () {
                    //change the navigations collection id with the one the user is taping
                    // to navigate to the correct URL
                    context
                        .read<NavigationTodoCubit>()
                        .selectedToDoCollectionChanged(item.id);
                    if (Breakpoints.small.isActive(context)) {
                      context.goNamed(
                        TodoDetailPage.pageConfig.name,
                        pathParameters: {
                          'collectionId': item.id.value,
                        },
                      );
                    }
                  },
                  leading: const Icon(Icons.circle),
                  title: Text(item.title),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              key: const Key('create-todo-collection'),
              heroTag: 'create-todo-collection',
              onPressed: () async {
                await context
                    .pushNamed(CreateTodoCollectionPage.pageConfig.name);
                if (context.mounted) {
                  final cubit = context.read<TodoOverviewCubit>();
                  cubit.readToDoCollections();
                }
              },
              child: Icon(CreateTodoCollectionPage.pageConfig.icon),
            ),
          ),
        )
      ],
    );
  }
}
