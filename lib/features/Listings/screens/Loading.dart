import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void fetchListings() async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();

    await listingsQuery.fetchShopifyGraphqlQuery(query.fetchProducts());
    Navigator.pushReplacementNamed(context, '/listings',
        arguments: {'productList': listingsQuery.shopifyQueryResult});
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
