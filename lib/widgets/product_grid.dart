import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';


class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
   
  });

 

  @override
  Widget build(BuildContext context) {
    final productData =Provider.of<ProductProvider>(context);
    final products = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (ctx, i) => ProductItem(
          products[i].id,
          products[i].title,
          products[i].imageUrl,
          products[i].price),
      itemCount: products.length,
    );
  }
}
