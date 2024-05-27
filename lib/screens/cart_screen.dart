import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total'),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text('\$${cart.totalAmount}', style: TextStyle(color: Theme.of(context).primaryTextTheme.titleSmall?.color),),
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ),
                TextButton(onPressed: (){}, child:  Text('ORDER NOW', style: TextStyle(color: Theme.of(context).colorScheme.primary),))
              ],
            ),
          )),
          
        ],
      ),
    );
  }
}
