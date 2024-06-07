import 'package:flutter/material.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/2_application/componets/todo_entry_item/todo_entry_item.dart';

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
          itemBuilder: (context, index) => ToDoEntryItemProvider(
              collectionId: collectionId, entryId: entryIds[index])),
    ));
  }
}