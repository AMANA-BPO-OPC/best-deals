import 'package:flutter/material.dart';

import 'package:best_deals/features/Listings/screens/Loading.dart';
import 'package:best_deals/features/Listings/screens/Listings.dart';
import 'package:best_deals/features/DealDetails/screens/DealDetails.dart';
import 'package:best_deals/features/DealDetails/screens/LoadingDealDetail.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/loadingProductList',
      routes: {
        '/loadingProductList': (context) => LoadingProductList(),
        '/listings': (context) => Listings(),
        '/dealDetails': (context) => DealDetails(),
        '/loadingDealDetail': (context) => LoadingDealDetail(),
      },
    ));
