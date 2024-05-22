import 'package:flutter/material.dart';

class cartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  cartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, cartItem> _items = {};

  Map<String, cartItem> get items {
    return {..._items};
  }
}
