import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/1_domain/entitites/todo_collection.dart';
import 'package:test_app/2_application/pages/details/todo_detail_page.dart';

class TodoOverviewLoaded extends StatelessWidget {
  const TodoOverviewLoaded({super.key, required this.collections});

  final List<TodoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: collections.length,
      itemBuilder: (context, index) {
        final item = collections[index];
        final colorScheme = Theme.of(context).colorScheme;

        return ListTile(
          tileColor: colorScheme.surface,
          selectedTileColor: colorScheme.onSurfaceVariant,
          iconColor: item.color.color,
          selectedColor: item.color.color,
          onTap: () {
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
  }
}
