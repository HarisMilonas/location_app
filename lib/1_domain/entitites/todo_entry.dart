import 'package:equatable/equatable.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';

class ToDoEntry extends Equatable {
  final String description;
  final bool isDone;
  final EntryId id;

  const ToDoEntry(
      {required this.id, required this.description, required this.isDone});

  factory ToDoEntry.empty() {
    return ToDoEntry(
      id: EntryId(),
      description: '',
      isDone: false,
    );
  }

  //basically make a new Object keep the id as is and if any other value is not changed
  //keep the original from that class
  ToDoEntry copyWith({String? description, bool? isDone}) {
    return ToDoEntry(
        id: id,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone);
  }

  @override
  List<Object?> get props => [description, isDone, id];
}
