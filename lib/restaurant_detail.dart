import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import 'package:food_zebra/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.title),
        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeAnimation: const badges.BadgeAnimation.rotation(
              animationDuration: Duration(seconds: 1),
              colorChangeAnimationDuration: Duration(seconds: 1),
              loopAnimation: false,
              curve: Curves.fastOutSlowIn,
              colorChangeAnimationCurve: Curves.easeInCubic,
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: const EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(4),
              elevation: 0,
            ),
            badgeContent: const Text('1', style: TextStyle(color: Colors.white, fontSize: 10)),
            child:
                IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {
                  // TODO: do something
                  Navigator.pop(context, 'toCart');
                }),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/${restaurant.image}'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(restaurant.description),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restaurant.menu.length,
              itemBuilder: (BuildContext context, int index) {
                final Dish dish = restaurant.menu[index];
                debugPrint('restaurant: $restaurant');
                return ListTile(
                  title: Text(dish.name),
                  subtitle: Text('\$${dish.price}'),
                  onTap: () {},
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
