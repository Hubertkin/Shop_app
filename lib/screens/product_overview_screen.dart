import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../providers/product_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/user_defined_badge.dart';
import '../providers/cart.dart';

enum FilterOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isLoading = false;
  @override
  void initState() {
    setState(() {
      
    _isLoading = true;
    });
    Future.delayed(Duration.zero).then((_) {  //this is used to run the code after the build method has run to avoid errors from using context when it is not available
      Provider.of<ProductProvider>(context, listen: false,).fetchAndSetProducts().then((_)  =>setState(() {
    _isLoading = false;
    }));
    });
    super.initState();
  }

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
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                  debugPrint(selectedValue.toString());
                });
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: FilterOptions.favorites,
                  child: Text('Only Favorites'),
                ),
                PopupMenuItem(
                  value: FilterOptions.all,
                  child: Text('Show All'),
                )
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => UserDefinedBadge(
                value: cart.itemCount.toString(),
                color: Theme.of(context).colorScheme.secondary,
                child: ch!,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    CartScreen.routeName,
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: _isLoading ? const Center(child: CircularProgressIndicator(),) : ProductGrid(_showOnlyFavorites));
  }
}
