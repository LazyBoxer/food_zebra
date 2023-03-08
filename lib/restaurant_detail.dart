import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import 'package:food_zebra/models/restaurant.dart';
import 'package:food_zebra/state/global_state.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  void _showDialog(BuildContext context, Dish dish) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('加入購物車'),
          content: Text('將 ${dish.name} 加入到購物車？'),
          actions: <Widget>[
            OutlinedButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlinedButton(
              child: const Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<GlobalState>(context, listen: false).addDish(dish);
              },
            ),
          ],
        );
      },
    );
  }

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
            badgeContent: Consumer<GlobalState>(
              builder: (context, state, child) {
                return Text('${state.dishes.length}', style: const TextStyle(color: Colors.white, fontSize: 10));
              },
            ),
            child:
                IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {
                  Navigator.pop(context, 'toCart');
                }),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(restaurant.image),
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
                return ListTile(
                  leading: dish.image != '' ? Image.network(
                    dish.image,
                    width: 100,
                    height: 100,
                  ) : null,
                  title: Text(dish.name),
                  subtitle: Text('\$${dish.price}'),
                  onTap: () {
                    _showDialog(context, dish);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
