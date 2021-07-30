import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:best_deals/features/Listings/screens/components/LeftNavigationDrawerWidget.dart';
import 'package:best_deals/features/Listings/screens/components/CategoryCollectionWidget.dart';
import 'package:best_deals/features/Listings/screens/components/ProductCards.dart';
import 'package:best_deals/features/Listings/screens/components/ListFilterWidget.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class Listings extends StatefulWidget {
  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
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

  Map data = {};
  ScrollController _scrollController = ScrollController();
  List shopifyProducts = [];
  List<String> shopifyIds = [];
  List shopifyCollections = [];
  Queries query = Queries();
  ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();
  bool isFirstListLoading = true;

  Future<void> _getMoreProductData(shopifyProductsLength) async {
    String cursor = shopifyProducts[shopifyProductsLength - 1]['cursor'];
    String queryArgument =
        'first:5,sortKey: CREATED_AT, reverse:true, query:"product_type:deal",after:"$cursor"';
    await listingsQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(queryArgument), 'product');
    shopifyProducts = listingsQuery.shopifyQueryResult!;
    listingsQuery.shopifyQueryResult!.forEach((product) {
      shopifyProducts.add(product);
    });
    setState(() {});
  }

  Future<void> _getFilterProductData() async {
    String queryArgument =
        'first:10, reverse:true, query:"product_type:deal AND vendor:Ebay"';
    await listingsQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(queryArgument), 'product');
    shopifyProducts.removeRange(0, shopifyProducts.length);
    shopifyProducts = listingsQuery.shopifyQueryResult!;
    isFirstListLoading = false;
    //setState(() {});
  }

  _getSharePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopifyIds = prefs.getStringList('sample1');
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    if (isFirstListLoading) {
      shopifyProducts = data['productList'];
    }
    shopifyCollections = data['collectionList'];

    List categoryCollections = [];
    shopifyCollections.forEach((collection) {
      if (collection['node']['description']
          .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
          .contains(RegExp('type=category'))) {
        categoryCollections.add(collection);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Deals'),
        centerTitle: true,
      ),
      drawer: LeftNavigationDrawerWidget(),
      // endDrawer: Drawer(
      //   child: Material(
      //     child: ListView(
      //         padding: EdgeInsets.symmetric(horizontal: 20),
      //         children: categoryCollections.map((categoryCollection) {
      //           return CategoryCollection(
      //               categoryCollection: categoryCollection);
      //         }).toList()),
      //   ),
      // ),
      endDrawer: ListFilterWidget(shopifyProducts: shopifyProducts),
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
