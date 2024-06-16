import 'package:flutter/material.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/user_product_screen.dart';
import './providers/product_provider.dart';
import 'providers/order.dart';
import 'screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'screens/edit_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ], // this syntax of provider is recommended for instantiating a new class like Productprovider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping cart',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
          //useMaterial3: true,
        ),
        //home: const ProductOverviewScreen(),
        //initialRoute: '/',
        routes: {
          '/': (ctx)=> const ProductOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrderScreen.routeName: (ctx)=> const OrderScreen(),
          UserProductScreen.routeName: (ctx)=> const UserProductScreen(),
          EditProductScreen.routeName: (ctx)=> const EditProductScreen(),
        },
      ),
    );
  }
}
