import 'package:flutter/material.dart';

import 'package:best_deals/features/Listings/screens/Loading.dart';
import 'package:best_deals/features/Listings/screens/Listings.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => Loading(),
        '/listings': (context) => Listings(),
      },
    ));
