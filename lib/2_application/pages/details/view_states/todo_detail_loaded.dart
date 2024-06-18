import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:test_app/2_application/pages/details/todo_entry_item/todo_entry_item.dart';

class TodoDetailLoaded extends StatelessWidget {
  const TodoDetailLoaded(
      {super.key, required this.collectionId, required this.entryIds});

  final CollectionId collectionId;
  final List<EntryId> entryIds;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ListView.builder(
              itemCount: entryIds.length,
              itemBuilder: (context, index) => ToDoEntryItemProvider(
                  collectionId: collectionId, entryId: entryIds[index])),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              key: const Key('create-todo-entry'),
              onPressed: () {
                context.pushNamed(CreateTodoEntryPage.pageConfig.name,
                    extra: collectionId);
              },
              child: const Icon(Icons.add_rounded),
            ),
          )
        ],
      ),
    ));
  }
}
