import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/product_provider.dart';

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
  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var isInit = true;
  var _isLoading = false;
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


  @override
  void didChangeDependencies() {
    if (isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        final productId = args as String;
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId);
        initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageURLController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      if ((!_imageURLController.text.startsWith('http') &&
              !_imageURLController.text.startsWith('https')) ||
          (!_imageURLController.text.endsWith('.png') &&
              !_imageURLController.text.endsWith('.jpg') &&
              !_imageURLController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() async{
    final isValid = _form.currentState!.validate();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _form.currentState!.save();
      if (_editedProduct.id != '') {
          Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct).then((value) {
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).pop();
            });
        
      } else {
        Provider.of<ProductProvider>(context, listen: false)
            .addProduct(_editedProduct)
            .catchError((error) {
          return showDialog<void>(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text("An error Ocurred!"),
                  content: const Text("Something went wrong."),
                  actions: [TextButton(onPressed: (){
                    Navigator.of(ctx).pop();
                  },child: const Text("Okay"),)],
                );
              },);
        }).then((value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        });
      }
      // setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // Navigator.of(context).pop();
    }
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(children: [
                  TextFormField(
                    initialValue: initValues['title'],
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
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite);
                    },
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    }),
                  ),
                  TextFormField(
                    initialValue: initValues['price'],
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_descriptionFocusNode),
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value!),
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Please enter a number greater than zero';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: initValues['description'],
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
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      if (value.length < 10) {
                        return 'Should be at least 10 characters long';
                      }
                      return null;
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
                          decoration:
                              const InputDecoration(labelText: "ImageUrl"),
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
                                imageUrl: value!,
                                isFavorite: _editedProduct.isFavorite);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an image URL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg')) {
                              return 'Please enter a valid image URL';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
    );
  }
}
