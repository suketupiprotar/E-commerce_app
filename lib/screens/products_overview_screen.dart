import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';

class ProductsOverviewScreen extends StatelessWidget {
  // const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (int selectedValue) {
              
            },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorite!'),
                      value: 0,
                    ),
                     PopupMenuItem(
                      child: Text('Show All!'),
                      value: 1,
                    ),
                  ]),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
