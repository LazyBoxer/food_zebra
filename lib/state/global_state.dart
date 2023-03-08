import 'package:flutter/material.dart';
import 'package:food_zebra/models/restaurant.dart';

class GlobalState extends ChangeNotifier {
  List<Dish> _dishes = [];

  List<Dish> get dishes => _dishes;


  void addDish(Dish dish) {
    _dishes.add(dish);
    notifyListeners();
  }
}
