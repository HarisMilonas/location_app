import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TodoEntryLoading extends StatelessWidget {
  const TodoEntryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 40,
        color: Colors.grey[100],
      ),
    );
  }
}
