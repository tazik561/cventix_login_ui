part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingCategoriesEvent extends CategoriesEvent {}

class TopCategoriesEvent extends CategoriesEvent {}

class SelectedCategoryEvent extends CategoriesEvent {
  final int id;
  SelectedCategoryEvent(this.id);
  List<Object> get props => [this.id];
}

class TriggeredItemEvent extends CategoriesEvent {
  final int id;
  TriggeredItemEvent(this.id);
  List<Object> get props => [this.id];
}
