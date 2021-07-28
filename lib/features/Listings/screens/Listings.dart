import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:best_deals/features/Listings/screens/components/ProductCards.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class Listings extends StatefulWidget {
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  Map data = {};
  ScrollController _scrollController = ScrollController();
  int _currentMax = 3;
  List shopifyProducts = [];
  List<String> shopifyIds = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _getSharePreferences();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreProductData(shopifyProducts.length);
      }
    });
  }

  Future<void> _getMoreProductData(shopifyProductsLength) async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();
    String cursor = shopifyProducts[shopifyProductsLength - 1]['cursor'];
    await listingsQuery
        .fetchShopifyGraphqlQuery(query.fetchProductsAfter(cursor));
    listingsQuery.shopifyQueryResult!.forEach((product) {
      shopifyProducts.add(product);
    });

    setState(() {});
  }

  _getSharePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopifyIds = prefs.getStringList('sample1');
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    shopifyProducts = data['productList'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Deals'),
        centerTitle: true,
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: shopifyProducts.length,
          itemBuilder: (context, index) {
            return ProductsCard(
                shopifyProducts: shopifyProducts,
                index: index,
                shopifyIds: shopifyIds);
          }),
    );
  }
}
