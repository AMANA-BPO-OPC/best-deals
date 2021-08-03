import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class LoadingCollectionProductList extends StatefulWidget {
  @override
  _LoadingCollectionProductListState createState() =>
      _LoadingCollectionProductListState();
}

class _LoadingCollectionProductListState
    extends State<LoadingCollectionProductList> {
  // void fetchListings() async {
  //   Queries query = Queries();
  //   ShopifyGQLConfigurations dealsListingQuery = ShopifyGQLConfigurations();
  //   ShopifyGQLConfigurations collectionListingQuery =
  //       ShopifyGQLConfigurations();

  //   List? productList;
  //   List? collectionList;

  //   String productQueryArgument =
  //       'first:5,sortKey: CREATED_AT, reverse:true, query:"product_type:deal"';
  //   await dealsListingQuery.fetchCollectionByHandle(
  //       query.fetchProducts(productQueryArgument), 'product');
  //   productList = dealsListingQuery.shopifyQueryResult;

  //   // String collectionQueryArgument = 'first:10, reverse: true';
  //   // await collectionListingQuery.fetchShopifyGraphqlQuery(
  //   //     query.fetchCollection(collectionQueryArgument), 'collection');

  //   collectionList = collectionListingQuery.shopifyQueryResult;

  //   Navigator.pushReplacementNamed(context, '/listings', arguments: {
  //     'productList': productList,
  //     'collectionList': collectionList
  //   });
  // }

  @override
  void initState() {
    super.initState();
    //fetchListings();
  }

  @override
  Widget build(BuildContext context) {
    Object? handleName = ModalRoute.of(context)!.settings.arguments;
    print(handleName);
    Navigator.of(context).pushReplacementNamed('/loadingCollectionProductList',
        arguments: {'handleName': handleName});
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: SpinKitCircle(color: Colors.blue[400], size: 50.0),
        ),
      ),
    );
  }
}
