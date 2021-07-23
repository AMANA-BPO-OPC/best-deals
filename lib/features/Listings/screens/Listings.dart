import 'package:flutter/material.dart';

import 'package:best_deals/features/Listings/screens/components/ProductCards.dart';

class Listings extends StatefulWidget {
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    List shopifyProducts = data['productList'];
    print(shopifyProducts);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Deals'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: shopifyProducts.length,
          itemBuilder: (context, index) {
            return ProductsCard(shopifyProducts: shopifyProducts, index: index);
          }),
    );
  }
}
