import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoEntryLoading extends StatelessWidget {
  const TodoEntryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        color: Theme.of(context).colorScheme.onSurface,
        child: const ListTile(
          title: Text('Loading ...'),
        ));
  }
}
