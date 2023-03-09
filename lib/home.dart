import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:food_zebra/models/model.dart';
import 'package:food_zebra/state/global_state.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'restaurant_detail.dart';

class HomePage extends StatefulWidget {
  final Function() toCart;

  const HomePage({super.key, required this.toCart});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    String data =
        await rootBundle.loadString('assets/restaurantDataSource.json');
    List items = json.decode(data);
    setState(() {
      restaurants = items.map((item) {
      List dishListJson = item['menu'] ?? [];
      List<Dish> dishList = dishListJson.map((dishJson) => Dish(name: dishJson['name'], price: dishJson['price'], image: (dishJson['image'] ?? ''))).toList();
      return Restaurant(
          title: item['title'],
          description: item['description'],
          image: item['image'],
          lat: item['lat'],
          lng: item['lng'],
          menu: dishList
        );
    }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          final restaurant = restaurants[index];
          return ListTile(
            leading: Image.asset(restaurant.image),
            title: Text(restaurant.title),
            subtitle: Text(restaurant.description),
            onTap: () async {
              Provider.of<GlobalState>(context, listen: false).setSelectedRestaurant(restaurant);
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantDetailPage(restaurant: restaurant)),
              );
              if (result == 'toCart') {
                widget.toCart();
              }
            },
          );
        },
      ),
    );
  }
}
