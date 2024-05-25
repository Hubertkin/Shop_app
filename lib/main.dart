import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import '../providers/product_provider.dart';
import 'screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(ctx)=>ProductProvider(),// this syntax of provider is recommended for instantiating a new class like Productprovider
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
          useMaterial3: false,
        ),
        home:  const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
