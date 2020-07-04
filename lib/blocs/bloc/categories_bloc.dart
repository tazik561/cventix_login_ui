import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());
  List<CategoriesItem> _catItems = [
    CategoriesItem(id: 1, title: "Sugar", prefixIcon: Icons.access_alarms),
    CategoriesItem(id: 2, title: "Calories", prefixIcon: Icons.access_alarms),
    CategoriesItem(id: 3, title: "Salt", prefixIcon: Icons.access_alarms),
    CategoriesItem(id: 4, title: "Fibre", prefixIcon: Icons.access_alarms),
    CategoriesItem(id: 5, title: "Fat", prefixIcon: Icons.access_alarms)
  ];

  List<CategoryItem> _infoCatItems = [
    CategoryItem(
        id: 1,
        catId: 2,
        delicious: "5",
        fat: "2.5g",
        fiber: "5.2g",
        kcal: "180 kcal",
        protein: "2.1 g",
        title: "Slow Tony",
        image: "assets/images/img1.jpeg"),
    CategoryItem(
        id: 2,
        catId: 2,
        delicious: "2",
        fat: "2 g",
        fiber: "5.2 g",
        kcal: "180 kcal",
        protein: "2.1 g",
        title: "Milk",
        image: "assets/images/img2.jpeg"),
    CategoryItem(
        id: 3,
        catId: 2,
        delicious: "5",
        fat: "2.5g",
        fiber: "5.2g",
        kcal: "180 kcal",
        protein: "2.1 g",
        title: "Meat",
        image: "assets/images/img3.jpeg"),
    CategoryItem(
        id: 4,
        catId: 2,
        delicious: "5",
        fat: "2.5g",
        fiber: "5.2g",
        kcal: "180 kcal",
        protein: "2.1 g",
        title: "Rice",
        image: "assets/images/img4.jpeg"),
  ];

  List<CategoryItem> get catItems => _infoCatItems;

  List<CategoriesItem> get items => _catItems;

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is TopCategoriesEvent) {
      yield* _makeCatList(items);
    }
    if (event is SelectedCategoryEvent) {
      yield* _makeSelectedCatList(event.id, items, _infoCatItems);
    }
    if (event is TriggeredItemEvent) {
      var tapedItem = items.firstWhere((element) => element.selected == true,
          orElse: () => null);
      tapedItem?.selected = false;

      var id = event.id;
      int itemIndex = items.indexWhere((element) => element.id == id);
      items[itemIndex].selected = true;
      yield* _makeSelectedCatList(event.id, items, _infoCatItems);
    }
  }

  Stream<CategoriesState> _makeCatList(List<CategoriesItem> items) async* {
    yield CategoriesLoaded(catItems: items, selectedCatItems: null);
  }

  Stream<CategoriesState> _makeSelectedCatList(int id,
      List<CategoriesItem> items, List<CategoryItem> selectedItem) async* {
    var selectedList =
        selectedItem.where((element) => element.catId == id).toList();
    yield CategoriesLoaded(catItems: items, selectedCatItems: selectedList);
  }
}

class CategoriesItem {
  final int id;
  final String title;
  final IconData prefixIcon;
  final IconData suffixIcon;
  bool selected;

  CategoriesItem(
      {this.id,
      this.title,
      this.prefixIcon,
      this.suffixIcon,
      this.selected = false});
}

class CategoryItem {
  final int id;
  final int catId;
  final String title;
  final String image;
  final String fat;
  final String kcal;
  final String protein;
  final String fiber;
  final String delicious;

  CategoryItem(
      {this.id,
      this.catId,
      this.title,
      this.image,
      this.fat,
      this.kcal,
      this.protein,
      this.fiber,
      this.delicious});
}
