part of 'navigation_todo_cubit.dart';

class NavigationTodoState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondbodyDisplayed;

  const NavigationTodoState({
    this.isSecondbodyDisplayed, this.selectedCollectionId
  });

  @override
  List<Object?> get props => [isSecondbodyDisplayed, selectedCollectionId];
}
