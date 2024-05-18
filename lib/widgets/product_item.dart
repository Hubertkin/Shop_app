import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  const ProductItem(this.id, this.title, this.imageUrl, this.price,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(// ClipRRect is a widget that clips its child using a rounded rectangle.
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Text('$price',
            textAlign: TextAlign.end,
            style: const TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black87,
                fontWeight: FontWeight.w700)),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName, arguments: id),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
