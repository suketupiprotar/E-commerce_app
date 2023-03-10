import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop_app/models/https_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavotitesOnly = false;

  final String authToken;

  Products(this.authToken,this._items);

  List<Product> get items {
    // if(_showFavotitesOnly)
    // {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  //  void showFavotitesOnly()
  //  {
  //     _showFavotitesOnly = true;
  //     notifyListeners();
  //  }
  //  void showAll()
  //  {
  //   _showFavotitesOnly = false;
  //   notifyListeners();
  //  }

  Future<void> fetchAndSetProducts() async {
    var url =
        Uri.parse('https://shopapp-965b8-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    // _items.add(value);
    var url =
        Uri.parse('https://shopapp-965b8-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
        // id: product.id,
      );

      _items.add(newProduct);
      // _items.insert(0,newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
  // return Future.value();
}

Future<void> updateProduct(String id, Product newProduct) async {
  final prodIndex = _items.indexWhere((prod) => prod.id == id);
  if (prodIndex > 0) {
    final url = Uri.parse(
        'https://shopapp-965b8-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
    await http.patch(
      url,
      body: json.encode(
        {
          'title': newProduct.title,
          'description': newProduct.description,
          ' imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        },
      ),
    );
    _items[prodIndex] = newProduct;
    notifyListeners();
  } else {
    print('...');
  }
}

Future<void> deleteProduct(String id) async {
  final url = Uri.parse(
      'https://shopapp-965b8-default-rtdb.firebaseio.com/products/$id..json?auth=$authToken');
  final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
  var existingProduct = _items[existingProductIndex];

  _items.removeAt(existingProductIndex);
  notifyListeners();
  // notifyListeners();
  final response = await http.delete(url);
  if (response.statusCode >= 400) {
    _items.insert(existingProductIndex, existingProduct);
    throw HttpException('Could Not delete Product.');
  }
  existingProduct = Null;

  // _items.removeWhere((prod) => prod.id == id);
}
