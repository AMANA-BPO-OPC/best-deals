import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class LoadingProductList extends StatefulWidget {
  @override
  _LoadingProductListState createState() => _LoadingProductListState();
}

class _LoadingProductListState extends State<LoadingProductList> {
  void fetchListings() async {
    Queries query = Queries();
    ShopifyGQLConfigurations dealsListingQuery = ShopifyGQLConfigurations();
    ShopifyGQLConfigurations collectionListingQuery =
        ShopifyGQLConfigurations();

    List? productList;
    List? collectionList;

    String productQueryArgument =
        'first:5,sortKey: CREATED_AT, reverse:true, query:"product_type:deal"';
    await dealsListingQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(productQueryArgument), 'product');
    productList = dealsListingQuery.shopifyQueryResult;

    String collectionQueryArgument = 'first:10, reverse: true';
    await collectionListingQuery.fetchShopifyGraphqlQuery(
        query.fetchCollection(collectionQueryArgument), 'collection');

    collectionList = collectionListingQuery.shopifyQueryResult;

    Navigator.pushReplacementNamed(context, '/listings', arguments: {
      'productList': productList,
      'collectionList': collectionList
    });
  }

  @override
  void initState() {
    super.initState();
    fetchListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(child: Text('Loading')),
      ),
    );
  }
}
