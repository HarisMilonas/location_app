import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/1_domain/entitites/todo_entry.dart';
import 'package:test_app/2_application/pages/entry/cubit/todo_entry_cubit.dart';

class TodoEntryLoaded extends StatelessWidget {
  const TodoEntryLoaded({super.key, required this.toDoEntry});

  final ToDoEntry toDoEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text(toDoEntry.description),
                const SizedBox(
                  width: 20,
                ),
                Icon(toDoEntry.isDone ? Icons.check : Icons.cancel)
              ],
            ),
            ElevatedButton(
              onPressed: () => BlocProvider.of<TodoEntryCubit>(context).updateEntry(toDoEntry) , child: Text('Update', 

            style: Theme.of(context).textTheme.displayLarge,))
          ],
        ),
      ),
    );
  }
}
