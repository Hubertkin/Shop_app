import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Form(
        child: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_priceFocusNode),
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
          )
        ]),
      ),
    );
  }
}
