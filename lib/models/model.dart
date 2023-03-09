import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Restaurant {
  final String title;
  final String description;
  final String image;
  final double lat;
  final double lng;
  final List<Dish> menu;

  Restaurant({
    required this.title,
    required this.description,
    required this.image,
    required this.lat,
    required this.lng,
    required this.menu,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'lat': lat,
      'lng': lng,
      'menu': menu.map((e) => e.toMap()).toList(),
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    List dishListJson = json['menu'] ?? [];
    List<Dish> dishList = dishListJson.map((dishJson) => Dish.fromJson(dishJson)).toList();
    return Restaurant(
          title: json['title'],
          description: json['description'],
          image: json['image'],
          lat: json['lat'],
          lng: json['lng'],
          menu: dishList
        );
  }
}



class Dish {
  String name;
  String image;
  int price;

  Dish({required this.name, required this.price, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(name: json['name'], price: json['price'], image: (json['image'] ?? ''));
  }
}



class Order {
  Restaurant restaurant;
  List<Dish> orderedDishes;

  Order({required this.restaurant, required this.orderedDishes});

  Map<String, dynamic> toMap() {
    return {
      'restaurant': restaurant.toMap(),
      'orderedDishes': orderedDishes.map((e) => e.toMap()).toList(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    List orderedDishesJson = json['menu'] ?? [];
    return Order(
      restaurant: Restaurant.fromJson(json['restaurant']),
      orderedDishes: orderedDishesJson.map((dishJson) => Dish.fromJson(dishJson)).toList()
    );
  }
}

Future<List<Order>> getOrders() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data = prefs.getString('HistoryOrders');
  if (data != null) {
    return List<Order>.from(
          json.decode(data).map((x) => Order.fromJson(x)));
  }

  return [];
}

void saveOrders(List<Order> orders) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('HistoryOrders', json.encode(orders.map((x) => x.toMap()).toList()));
}

