import 'package:flutter/material.dart';
import 'package:food_zebra/feedback.dart';
import 'package:food_zebra/order_history.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

// create a widget that has 2 buttons on it. Oen button will navigate to the OrderHistory page and the other button will navigate to the Feedbacks page.
class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderHistoryPage()));
              },
              child: const Text('歷史訂單'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeedbackPage()));
              },
              child: const Text('問題回報'),
            ),
          ],
        ),
      ),
    );
  }
}
