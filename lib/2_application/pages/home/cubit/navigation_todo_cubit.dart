import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:test_app/1_domain/entitites/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoState> {
  NavigationTodoCubit() : super(const NavigationTodoState());

  void selectedToDoCollectionChanged(CollectionId collectionId) {
    emit(NavigationTodoState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    emit(NavigationTodoState(
        isSecondbodyDisplayed: isSecondBodyDisplayed,
        selectedCollectionId: state.selectedCollectionId));
  }
}
