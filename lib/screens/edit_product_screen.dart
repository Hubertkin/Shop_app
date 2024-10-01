import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _imageURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    super.initState();
    _imageURLFocusNode.addListener(_updateImageURL);
  }

  @override
  void dispose() {
    super.dispose();
    _imageURLFocusNode.removeListener(_updateImageURL);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLController.dispose();
    _imageURLFocusNode.dispose();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState?.save();
    debugPrint(_editedProduct.title);
    debugPrint(_editedProduct.price.toString());
    debugPrint(_editedProduct.description);
    debugPrint(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Form(
        child: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_priceFocusNode),
            onSaved: (value) {
              _editedProduct = Product(
                  id: _editedProduct.id,
                  title: value!,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl);
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_descriptionFocusNode),
            onSaved: (value) {
              _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: _editedProduct.description,
                  price: double.parse(value!),
                  imageUrl: _editedProduct.imageUrl);
            },
          ),
          TextFormField(
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
            focusNode: _descriptionFocusNode,
            onSaved: (value) {
              _editedProduct = Product(
                  id: _editedProduct.id,
                  title: _editedProduct.title,
                  description: value!,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl);
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: _imageURLController.text.isEmpty
                    ? const Text("Enter a URL")
                    : FittedBox(
                        child: Image.network(
                        _imageURLController.text,
                        fit: BoxFit.cover,
                      )),
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "ImageUrl"),
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  controller: _imageURLController,
                  focusNode: _imageURLFocusNode,
                  onFieldSubmitted: (_) => _saveForm(),
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: value!);
                  },
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
