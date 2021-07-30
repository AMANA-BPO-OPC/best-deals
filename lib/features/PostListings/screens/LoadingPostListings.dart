import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class LoadingPostListings extends StatefulWidget {
  @override
  _LoadingPostListingsState createState() => _LoadingPostListingsState();
}

class _LoadingPostListingsState extends State<LoadingPostListings> {
  void fetchPostListings() async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();

    await listingsQuery.fetchShopifyGraphqlQuery(query.fetchPosts(), 'product');
    Navigator.pushReplacementNamed(context, '/postListings',
        arguments: {'postList': listingsQuery.shopifyQueryResult});
  }

  @override
  void initState() {
    super.initState();
    fetchPostListings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Post Listings Loading!!!'),
      ),
    );
  }
}
