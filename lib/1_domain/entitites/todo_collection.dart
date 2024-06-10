import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/todo_color.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';

class TodoCollection extends Equatable {
  final CollectionId id;
  final String title;
  final ToDoColor color;

  TodoCollection copyWith({String? title, ToDoColor? color}) {
    return TodoCollection(
        id: id, title: title ?? this.title, color: color ?? this.color);
  }

  factory TodoCollection.empty() {
    return TodoCollection(
        id: CollectionId(), title: '', color: ToDoColor(colorIndex: 0));
  }

  const TodoCollection(
      {required this.id, required this.title, required this.color});

  @override
  List<Object?> get props => [id, title, color];
}
