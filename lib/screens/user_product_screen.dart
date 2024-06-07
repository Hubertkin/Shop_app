import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return Scaffold(appBar: AppBar(title: const Text("Your Products"),actions: [
      IconButton(icon: const Icon(Icons.add), onPressed: (){
        //.
      })
    ],),
    body: Padding(padding: EdgeInsets.all(8),child: 
    ListView.builder(itemBuilder: ,itemCount: productData.items.length,),);
  );}
}