import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});
  static const routeName = '/product-detail';

  // final String title;
  // const ProductDetailScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =Provider.of<ProductProvider>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        title:  Text(loadedProduct.title),
      ),
    );
  }
}   
