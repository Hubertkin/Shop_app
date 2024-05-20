import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
          title: const Text('My Shop'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              onSelected: (int selectedValue) {
                if (selectedValue == 0) {
                  // show only favorites
                } else {
                  // show all
                }
                debugPrint(selectedValue.toString());
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: 0,
                  child: Text('Only Favorites'),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Show All'),
                )
              ],
            )
          ],
        ),
        body: const ProductGrid());
  }
}
