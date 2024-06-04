import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double price;

  const ProductItem(
      //this.id, this.title, this.imageUrl, this.price,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final cart =Provider.of<Cart>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      // ClipRRect is a widget that clips its child using a rounded rectangle.
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Text('${product.price}',
            textAlign: TextAlign.end,
            style: const TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black87,
                fontWeight: FontWeight.w700)),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(//This widget is used on part of the whole widget in this file that needs a constant listening to rebuild 
          //but the other parts doesn't need a rebuild
          // the child argument is used on widgets that doesn't need a rebuild
            builder: (ctx, product, child) => IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavoriteStatus();
                },
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
               cart.addItem(product.id, product.price, product.title);
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                   content: const Text('Added item to cart!'),
                   duration: const Duration(seconds: 2),
                   action: SnackBarAction(
                     label: 'UNDO',
                     onPressed: () {
                       cart.removeSingleItem(product.id);
                     },
                   ),
                 ),
               );
            },
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
