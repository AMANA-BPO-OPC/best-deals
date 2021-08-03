import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';
import 'package:best_deals/common/services/ShopifyProduct/ProductDetails.dart';

class LoadingDealDetail extends StatefulWidget {
  @override
  _LoadingDealDetailState createState() => _LoadingDealDetailState();
}

class _LoadingDealDetailState extends State<LoadingDealDetail> {
  void fetchListings(dealDetails) async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();

    String productCursor = dealDetails['productDetails']['productCursor'];
    bool hasProductBefore = false;
    bool hasProductAfter = false;
    Map? productBefore;
    Map? productAfter;

    String beforeQueryArgument =
        'last:1, reverse: true, sortKey: CREATED_AT, query:"product_type:deal", before:"$productCursor"';
    await listingsQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(beforeQueryArgument), 'product');

    if (listingsQuery.shopifyQueryResult != null) {
      if (listingsQuery.shopifyQueryResult!.isNotEmpty) {
        hasProductBefore = true;
        productBefore = ProductDetails(listingsQuery.shopifyQueryResult!, 0);
      }
    }

    String afterQueryArgument =
        'first:5,sortKey: CREATED_AT, reverse:true, query:"product_type:deal",after:"$productCursor"';
    await listingsQuery.fetchShopifyGraphqlQuery(
        query.fetchProducts(afterQueryArgument), 'product');

    if (listingsQuery.shopifyQueryResult != null) {
      if (listingsQuery.shopifyQueryResult!.isNotEmpty) {
        hasProductAfter = true;
        productAfter = ProductDetails(listingsQuery.shopifyQueryResult!, 0);
      }
    }

    Navigator.pushReplacementNamed(context, '/dealDetails', arguments: {
      'productDetails': dealDetails,
      'hasProductBefore': hasProductBefore,
      'productBefore': productBefore,
      'hasProductAfter': hasProductAfter,
      'productAfter': productAfter,
    });
  }

  @override
  Widget build(BuildContext context) {
    Map dealDetails = ModalRoute.of(context)!.settings.arguments as Map;
    fetchListings(dealDetails);

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
