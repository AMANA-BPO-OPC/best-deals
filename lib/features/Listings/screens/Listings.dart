import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:best_deals/features/Listings/screens/components/LeftNavigationDrawerWidget.dart';
import 'package:best_deals/features/Listings/screens/components/RightNavigationDrawerWidget.dart';
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
  List shopifyProducts = [];
  List<String> shopifyIds = [];
  List shopifyCollections = [];
  Queries query = Queries();
  ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();
  bool isFirstListLoading = true;
  int currentIndex = 0;
  String rightDrawerName = 'collections';

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
      endDrawer: RightNavigationDrawerWidget(
          rightDrawerName: rightDrawerName,
          categoryCollections: categoryCollections,
          allProductList: data['allProductList']),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: shopifyProducts.length,
          itemBuilder: (context, index) {
            return ProductsCard(
                shopifyProducts: shopifyProducts,
                index: index,
                shopifyIds: shopifyIds);
          }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[100],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              setState(() {
                rightDrawerName = 'collections';
                currentIndex = index;
              });
              break;
            case 1:
              setState(() {
                rightDrawerName = 'info';
                currentIndex = index;
              });
              break;
            case 2:
              setState(() {
                rightDrawerName = 'filter';
                currentIndex = index;
              });
              break;
            case 3:
              setState(() {
                currentIndex = index;
              });
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Collections',
              backgroundColor: Colors.cyan),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter),
              label: 'Filter',
              backgroundColor: Colors.amber),
        ],
      ),
    );
  }

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

  _getSharePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shopifyIds = prefs.getStringList('sample1');
  }
}
