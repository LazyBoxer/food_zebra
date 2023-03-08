import 'package:flutter/material.dart';
import 'package:food_zebra/models/restaurant.dart';
import 'package:food_zebra/state/global_state.dart';
import 'package:food_zebra/widgets/store_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            '商品資訊',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Consumer<GlobalState>(builder: (context, state, child) {
            return ListView.builder(
                itemCount: state.dishes.length,
                itemBuilder: (BuildContext context, int index) {
                  Dish dish = state.dishes[index];
                  return ListTile(
                    title: Text(dish.name),
                    subtitle: Text('${dish.price}'),
                  );
                });
          })),
          const StoreMap(targetPosition: LatLng(24.344786, 120.623790)),
          Consumer<GlobalState>(builder: (context, state, child) {
            return Text('總計金額: ${state.dishes.fold(0.0, (previousValue, element) => previousValue + element.price)}');
          }),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement checkout functionality
              },
              child: const Text('結帳'),
            ),
          ),
        ],
      ),
    );
  }
}
