part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoriesItem> catItems;
  final List<CategoryItem> selectedCatItems;
  CategoriesLoaded({this.catItems, this.selectedCatItems});

  @override
  List<Object> get props => [catItems, selectedCatItems];
}
