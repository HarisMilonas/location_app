import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/1_domain/entitites/todo_color.dart';
import 'package:test_app/1_domain/repository/todo_repository.dart';
import 'package:test_app/1_domain/usecases/create_todo_collection.dart';
import 'package:test_app/2_application/core/page_config.dart';
import 'package:test_app/2_application/pages/create_todo_collection/cubit/create_todo_collection_page_cubit.dart';

class CreateToDoCollectionPageProvider extends StatelessWidget {
  const CreateToDoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoCollectionPageCubit>(
      create: (context) => CreateToDoCollectionPageCubit(
        createToDoCollection: CreateTodoCollection(
          todoRepository: RepositoryProvider.of<TodoRepository>(context),
        ),
      ),
      child: const CreateTodoCollectionPage(),
    );
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  const CreateTodoCollectionPage({super.key});

  static const pageConfig = PageConfig(
      icon: Icons.add_task_rounded,
      name: 'create_todo_colllection',
      child: CreateToDoCollectionPageProvider());

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => context
                  .read<CreateToDoCollectionPageCubit>()
                  .titleChanged(value),
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a titile!';
                }
                return null;
              },
            ),
            TextFormField(
              onChanged: (value) => context
                  .read<CreateToDoCollectionPageCubit>()
                  .colorChanged(value),
              decoration: const InputDecoration(labelText: 'Color'),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColorIndex = int.tryParse(value);
                  if (parsedColorIndex == null ||
                      parsedColorIndex < 0 ||
                      parsedColorIndex > ToDoColor.predefinedColors.length) {
                    return 'Only numbers between 0 and ${ToDoColor.predefinedColors.length - 1} are allowed!';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  final isValid = _formkey.currentState?.validate();
                  if (isValid == true) {
                    //call cubit to store data
                    context.read<CreateToDoCollectionPageCubit>().submit();
                    context.pop();
                  }
                },
                child: const Text('Save Collection'))
          ],
        ),
      ),
    );
  }
}
