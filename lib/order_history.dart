// create a new file called order_history.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_zebra/models/model.dart';
import 'package:food_zebra/state/global_state.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrderHistoryPageState();
  }
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Order> _savedOrders = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<Order> orders = await getOrders();
    setState(() {
      _savedOrders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('歷史訂單'),
      ),
      body: Column(
        children: [
          const Text(
            '訂單紀錄',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _savedOrders.length,
            itemBuilder: (BuildContext context, int index) {
              Order order = _savedOrders[index];
              return ListTile(
                leading: Image.asset(order.restaurant.image),
                title: Text(order.restaurant.title),
                subtitle: Text(order.restaurant.description),
              );
            },
          ))
        ],
      ),
    );
  }
}
