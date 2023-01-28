import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/products_grid.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import 'package:shop_app/providers/products.dart';

enum FilterOption {
  Favorite,
  All,  
}

class ProductsOverviewScreen extends StatelessWidget {
  // const ProductsOverviewScreen({super.key});
  final productsContainer = Provider.of<Products>(context,listen: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              if (selectedValue == FilterOption.Favorite) {
                productsContainer.showFavotitesOnly();
              }
              else{

              }
            },
              icon: Icon(
                Icons.more_vert,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorite!'),
                      value: FilterOption.Favorite,
                    ),
                     PopupMenuItem(
                      child: Text('Show All!'),
                      value: FilterOption.All,
                    ),
                  ]),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
