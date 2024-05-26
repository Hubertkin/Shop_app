import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body:  Column(
        children: [
         const  Card(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const Text('Total'),
                const  SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text('\$${cart.totalAmount}'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
