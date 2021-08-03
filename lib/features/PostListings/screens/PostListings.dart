import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';
import 'package:best_deals/features/PostListings/screens/components/PostsCard.dart';

class PostListings extends StatefulWidget {
  @override
  _PostListingsState createState() => _PostListingsState();
}

class _PostListingsState extends State<PostListings> {
  Map data = {};
  ScrollController _scrollController = ScrollController();
  int _currentMax = 3;
  List shopifyPosts = [];
  List<String> shopifyIds = [];

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMorePostData(shopifyPosts.length);
      }
    });
  }

  Future<void> _getMorePostData(shopifyPostsLength) async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();
    String cursor = shopifyPosts[shopifyPostsLength - 1]['cursor'];
    await listingsQuery.fetchShopifyGraphqlQuery(
        query.fetchPostsAfter(cursor), 'product');
    listingsQuery.shopifyQueryResult!.forEach((product) {
      shopifyPosts.add(product);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    shopifyPosts = data['postList'];
    print('Post Listings build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Deals'),
        centerTitle: true,
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: shopifyPosts.length,
          itemBuilder: (context, index) {
            return PostsCard(
              shopifyPosts: shopifyPosts,
              index: index,
            );
          }),
    );
  }
}
