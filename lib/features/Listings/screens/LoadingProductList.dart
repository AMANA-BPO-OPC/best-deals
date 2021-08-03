import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class LoadingProductList extends StatefulWidget {
  @override
  _LoadingProductListState createState() => _LoadingProductListState();
}

class _LoadingProductListState extends State<LoadingProductList> {
  void fetchListings() async {
    Queries query = Queries();
    ShopifyGQLConfigurations allDealsListingQuery = ShopifyGQLConfigurations();
    ShopifyGQLConfigurations dealsListingQuery = ShopifyGQLConfigurations();
    ShopifyGQLConfigurations collectionListingQuery =
        ShopifyGQLConfigurations();

    List? allProductList;
    List? productList;
    List? collectionList;

    String allProductQueryArgument =
        'first:205,sortKey: CREATED_AT, reverse:true';
    await allDealsListingQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(allProductQueryArgument), 'product');
    allProductList = allDealsListingQuery.shopifyQueryResult;

    String productQueryArgument =
        'first:5,sortKey: CREATED_AT, reverse:true, query:"product_type:deal"';
    await dealsListingQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(productQueryArgument), 'product');
    productList = dealsListingQuery.shopifyQueryResult;

    String collectionQueryArgument = 'first:250, reverse: true';
    await collectionListingQuery.fetchShopifyGraphqlQuery(
        query.fetchCollection(collectionQueryArgument), 'collection');

    collectionList = collectionListingQuery.shopifyQueryResult;

    Navigator.pushReplacementNamed(context, '/listings', arguments: {
      'allProductList': allProductList,
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
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: SpinKitCircle(color: Colors.blue[400], size: 50.0),
        ),
      ),
    );
  }
}
