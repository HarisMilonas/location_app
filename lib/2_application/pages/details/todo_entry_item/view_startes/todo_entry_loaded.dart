import 'package:flutter/material.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';


class TodoEntryLoaded extends StatelessWidget {
  const TodoEntryLoaded({super.key, required this.entryItem, required this.onChanged});

  final ToDoEntry entryItem;

  // make it as a callback
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(entryItem.description),
      value: entryItem.isDone, 
      onChanged: onChanged
      );
  }
}
