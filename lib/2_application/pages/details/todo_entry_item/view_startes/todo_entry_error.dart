import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/2_application/pages/details/todo_entry_item/cubit/todo_entry_cubit.dart';

class TodoEntryError extends StatelessWidget {
  const TodoEntryError({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: null,
      leading: const Icon(Icons.warning_rounded),
      title: const Text('Could not load item'),
      trailing: IconButton(
          onPressed: context.read<TodoEntryCubit>().fetch,
          icon: const Icon(Icons.refresh_rounded)),
    );
  }
}
