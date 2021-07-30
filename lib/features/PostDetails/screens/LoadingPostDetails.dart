import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';
import 'package:best_deals/common/services/ShopifyProduct/ProductDetails.dart';

class LoadingPostDetails extends StatefulWidget {
  @override
  _LoadingPostDetailsState createState() => _LoadingPostDetailsState();
}

class _LoadingPostDetailsState extends State<LoadingPostDetails> {
  void fetchPosts(postDetails) async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();
    bool hasPostBefore = false;
    bool hasPostAfter = false;
    Map? postBefore;
    Map? postAfter;

    // await listingsQuery.fetchShopifyGraphqlQuery(query
    //     .fetchProductsBefore(dealDetails['productDetails']['productCursor']));

    // if (listingsQuery.shopifyQueryResult != null) {
    //   if (listingsQuery.shopifyQueryResult!.isNotEmpty) {
    //     hasProductBefore = true;
    //     productBefore = ProductDetails(listingsQuery.shopifyQueryResult!, 0);
    //   }
    // }

    await listingsQuery.fetchShopifyGraphqlQuery(
        query.fetchPostsAfter(postDetails['postDetails']['productCursor']),
        'product');

    if (listingsQuery.shopifyQueryResult != null) {
      if (listingsQuery.shopifyQueryResult!.isNotEmpty) {
        hasPostAfter = true;
        postAfter = ProductDetails(listingsQuery.shopifyQueryResult!, 0);
      }
    }

    Navigator.pushReplacementNamed(context, '/postDetails', arguments: {
      'postDetails': postDetails,
      'hasPostBefore': hasPostBefore,
      'postBefore': postBefore,
      'hasPostAfter': hasPostAfter,
      'productAfter': postAfter,
    });
  }

  @override
  Widget build(BuildContext context) {
    Map postDetails = ModalRoute.of(context)!.settings.arguments as Map;
    fetchPosts(postDetails);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(child: Text('Post Details Loading')),
      ),
    );
  }
}
