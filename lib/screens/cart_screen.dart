import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../providers/order.dart';
import '../widgets/cart_item.dart';

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
          Card(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleSmall
                                ?.color),
                      ),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                    ),
                    TextButton(
                      onPressed: () {
                        if (cart.totalAmount > 0) {
                          Provider.of<Orders>(
                            context,
                            listen: false,
                          ).addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                          cart.clearCart();
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar( 
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content:  Text('Add items to cart to order.'),
                              duration:  Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'ORDER NOW',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title),
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
