import 'package:flutter/material.dart';
import 'package:food_zebra/models/model.dart';
import 'package:food_zebra/state/global_state.dart';
import 'package:food_zebra/widgets/store_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final Function() toHome;

  const CartPage({super.key, required this.toHome});

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            '店家資訊',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Consumer<GlobalState>(builder: (context, state, child) {
            return Text(state.selectedRestaurant?.title ?? '',
                style: const TextStyle(fontSize: 20.0));
          }),
          const SizedBox(
            height: 200,
            child: StoreMap(targetPosition: LatLng(25.045310925008376, 121.51608931176183)),
          ),
          const Padding(padding: EdgeInsets.only(top: 16), child: Text(
            '餐點清單',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
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
          Consumer<GlobalState>(builder: (context, state, child) {
            return Text(
                '總計金額: ${state.dishes.fold(0.0, (previousValue, element) => previousValue + element.price)}',
                style: const TextStyle(fontSize: 20.0));
          }),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                List<Order> savedOrders = await getOrders();
                // ignore: use_build_context_synchronously
                var state = Provider.of<GlobalState>(context, listen: false);
                Order newOrderedRestaurant = Order(restaurant: state.selectedRestaurant!, orderedDishes: state.dishes);
                savedOrders.add(newOrderedRestaurant);
                saveOrders(savedOrders);
                
                widget.toHome();
              },
              child: const Text('結帳'),
            ),
          ),
        ],
      ),
    );
  }
}
