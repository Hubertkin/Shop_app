import 'package:flutter/material.dart';
import '../providers/product_provider.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavs;
  const ProductGrid(this.showFavs,{
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    final products = showFavs ? productData.favoriteItems: productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[
            i], //instantiating all products objects and making them avaible in productitem widget
//.value is recommended when using already existing objects
//and it also binds the widgets with it data to prevent flutter from recycling, causing bugs for more grid objects created
//it also clears data that is not in use from memory

        child: const ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            // products[i].price
            ),
      ),
      itemCount: products.length,
    );
  }
}
