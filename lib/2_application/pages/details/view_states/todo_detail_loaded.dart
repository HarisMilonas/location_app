import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/2_application/pages/entry/todo_entry_page.dart';

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
      child: ListView.builder(
        itemCount: entryIds.length,
        itemBuilder: (context, index) {
          final EntryId item = entryIds[index];
         return ListTile(
            title: Text(item.value),
            onTap: () => context.pushNamed(TodoEntryPage.pageConfig.name,
            pathParameters: {
              'collectionId' : collectionId.value,
              'entryId' : item.value
            }
            ),
          );
        },
      ),
    ));
  }
}
