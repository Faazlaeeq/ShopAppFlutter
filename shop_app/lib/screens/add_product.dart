import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';

import '../provider/products.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _priceNode = FocusNode();
  final _descNode = FocusNode();
  final _imgNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _initSet = false;
  var _isloaded = false;
  late String? _pId;
  var _editedProduct =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");
  late Product _initialValue;

  @override
  void initState() {
    _imgNode.addListener(_updateImage);
    _initSet = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_initSet) {
      _pId = ModalRoute.of(context)?.settings.arguments as String?;
      if (_pId != null) {
        _initialValue = Provider.of<Products>(context).findById(_pId);

        _titleController.text = _initialValue.title;
        _priceController.text = _initialValue.price.toString();
        _descController.text = _initialValue.description;
        _imgUrlController.text = _initialValue.imageUrl;
      }
    }
    _initSet = false;
    super.didChangeDependencies();
  }

  void _updateImage() {
    if (!_imgNode.hasFocus) {
      setState(() {});
    }
  }

  void _save() async {
    final isValid = _form.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    if (_pId == null) {
      _editedProduct = Product(
          id: "",
          title: _titleController.text,
          description: _descController.text,
          price: double.parse(_priceController.text),
          imageUrl: _imgUrlController.text);
      setState(() {
        _isloaded = true;
      });

      Provider.of<Products>(context, listen: false)
          .additem(_editedProduct)
          .catchError((onError) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Error"),
                  content: Text(onError.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"))
                  ],
                ));
      }).then((_) {
        Navigator.of(context).pop(true);
      });
    } else {
      Product newProd = Product(
          id: _pId ?? "",
          title: _titleController.text,
          description: _descController.text,
          price: double.parse(_priceController.text),
          imageUrl: _imgUrlController.text,
          isFavorate: _initialValue.isFavorate);

      await Provider.of<Products>(context, listen: false)
          .updateProduct(_pId ?? "", newProd);

      Navigator.of(context).pop(true);
    }
    setState(() {
      _isloaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Products"),
        actions: [
          IconButton(
              onPressed: () {
                _save();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: _isloaded
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _form,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Title"),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _titleController,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_priceNode),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Title is required!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Price"),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: _priceController,
                        focusNode: _priceNode,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_descNode),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Price is required!";
                          }
                          if (double.tryParse(val) == null) {
                            return "Enter valid price.";
                          }
                          if (double.parse(val) <= 0) {
                            return "Enter price greater than 0.";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        controller: _descController,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_imgNode),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Please enter Description";
                          }

                          return null;
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            child: _imgUrlController.text.isEmpty
                                ? const Text("Enter Url")
                                : FittedBox(
                                    fit: BoxFit.contain,
                                    child:
                                        Image.network(_imgUrlController.text)),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Image Url"),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              focusNode: _imgNode,
                              onFieldSubmitted: (_) {
                                setState(() {});
                              },
                              controller: _imgUrlController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Image Url is required!";
                                }
                                var urlPattern =
                                    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                                var result =
                                    RegExp(urlPattern, caseSensitive: false)
                                        .firstMatch(val);
                                if (result == null) {
                                  return "Enter correct Url";
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }

  @override
  void dispose() {
    _priceNode.dispose();
    _imgNode.dispose();
    _descNode.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }
}
