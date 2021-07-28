import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';
import 'package:best_deals/features/Listings/services/ProductDetails.dart';

class LoadingDealDetail extends StatefulWidget {
  @override
  _LoadingDealDetailState createState() => _LoadingDealDetailState();
}

class _LoadingDealDetailState extends State<LoadingDealDetail> {
  void fetchListings(dealDetails) async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();
    bool hasProductBefore = false;
    bool hasProductAfter = false;
    Map? productBefore;
    Map? productAfter;

    await listingsQuery.fetchShopifyGraphqlQuery(query
        .fetchProductsBefore(dealDetails['productDetails']['productCursor']));

    if (listingsQuery.shopifyQueryResult != null) {
      if (listingsQuery.shopifyQueryResult!.isNotEmpty) {
        hasProductBefore = true;
        productBefore = ProductDetails(listingsQuery.shopifyQueryResult!, 0);
      }
    }

    await listingsQuery.fetchShopifyGraphqlQuery(query
        .fetchProductsAfter(dealDetails['productDetails']['productCursor']));

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
        child: Center(child: Text('Deal Loading')),
      ),
    );
  }
}
