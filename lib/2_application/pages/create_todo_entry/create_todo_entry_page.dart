import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/0_data/repository/todo_repository_mock.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/1_domain/usecases/create_todo_entry.dart';
import 'package:test_app/2_application/core/form_value.dart';
import 'package:test_app/2_application/core/page_config.dart';
import 'package:test_app/2_application/pages/create_todo_entry/cubit/create_todo_entry_page_cubit.dart';

class CreateTodoEntryPageProvider extends StatelessWidget {
  const CreateTodoEntryPageProvider({super.key, required this.collectionId});

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateTodoEntryPageCubit>(
      create: (context) => CreateTodoEntryPageCubit(
          collectionId: collectionId,
          addTodoEntry: CreateTodoEntry(
              todoRepository:
                  RepositoryProvider.of<TodoRepositoryMock>(context))),
      child: const CreateTodoEntryPage(),
    );
  }
}

class CreateTodoEntryPage extends StatefulWidget {
  const CreateTodoEntryPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_entry',
    child: Placeholder(),
  );

  @override
  State<CreateTodoEntryPage> createState() => _CreateTodoEntryPageState();
}

class _CreateTodoEntryPageState extends State<CreateTodoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'description'),
                validator: (value) {
                  final currentValidationState = context
                          .read<CreateTodoEntryPageCubit>()
                          .state
                          .description
                          ?.validationStatus ??
                      ValidationStatus.pending;
                  switch (currentValidationState) {
                    case ValidationStatus.error:
                      return 'This field need at least 2 characters to be valid';
                    case ValidationStatus.success:
                    case ValidationStatus.pending:
                      return null;
                  }
                },
                onChanged: (value) => context.read<CreateTodoEntryPageCubit>(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid == true) {
                      context.read<CreateTodoEntryPageCubit>().submit();
                      context.pop();
                    }
                  },
                  child: const Text('save entry'))
            ],
          )),
    );
  }
}
