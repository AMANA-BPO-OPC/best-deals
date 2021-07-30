import 'package:flutter/material.dart';

import 'package:best_deals/features/Listings/screens/LoadingProductList.dart';
import 'package:best_deals/features/Listings/screens/LoadingCollectionProductList.dart';
import 'package:best_deals/features/Listings/screens/Listings.dart';
import 'package:best_deals/features/DealDetails/screens/LoadingDealDetail.dart';
import 'package:best_deals/features/DealDetails/screens/DealDetails.dart';
import 'package:best_deals/features/PostListings/screens/LoadingPostListings.dart';
import 'package:best_deals/features/PostListings/screens/PostListings.dart';
import 'package:best_deals/features/PostDetails/screens/LoadingPostDetails.dart';
import 'package:best_deals/features/PostDetails/screens/PostDetails.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/loadingProductList',
      routes: {
        '/loadingProductList': (context) => LoadingProductList(),
        '/loadingCollectionProductList': (context) =>
            LoadingCollectionProductList(),
        '/listings': (context) => Listings(),
        '/loadingDealDetail': (context) => LoadingDealDetail(),
        '/dealDetails': (context) => DealDetails(),
        '/loadingPostListings': (context) => LoadingPostListings(),
        '/postListings': (context) => PostListings(),
        '/loadingPostDetails': (context) => LoadingPostDetails(),
        '/postDetails': (context) => PostDetails(),
      },
    ));
