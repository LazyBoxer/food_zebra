import 'package:flutter/material.dart';
import 'package:food_zebra/models/model.dart';

class GlobalState extends ChangeNotifier {
  List<Dish> _dishes = [];
  Restaurant? _selectedRestaurant;

  Restaurant? get selectedRestaurant => _selectedRestaurant;
  List<Dish> get dishes => _dishes;

  void addDish(Dish dish) {
    _dishes.add(dish);
    notifyListeners();
  }

  void setSelectedRestaurant(Restaurant restaurant) {
    if (_selectedRestaurant?.title != restaurant.title) {
      _selectedRestaurant = restaurant;
      _dishes = [];
    }
  }
}
