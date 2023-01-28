import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
    this.id,
    this.title,
    this.quantity,
    this.price,
  );
}

class Cart with ChangeNotifier {
  late Map<String,CartItem> _items;

  Map<String,CartItem> get items {
    return {..._items}; 
  }

  void addItem(String productId,String price,String title,)
  {
    if(_items.containsKey(key))
  }

}
