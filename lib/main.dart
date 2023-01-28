import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import './screens/products_overview_screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      // create: (ctx) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          PruductDetailScreen.routeName: (ctx) => PruductDetailScreen(),
        },
      ),
    );
  }
}
