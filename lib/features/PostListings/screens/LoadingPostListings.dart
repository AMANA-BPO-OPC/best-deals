import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    print('loading post detail');
    return Scaffold(
      body: Center(
        child: Center(
          child: SpinKitCircle(color: Colors.blue[400], size: 50.0),
        ),
      ),
    );
  }
}
