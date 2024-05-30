import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem
({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(padding: EdgeInsets.all(8),child: ListTile(),),
    );
  }
}