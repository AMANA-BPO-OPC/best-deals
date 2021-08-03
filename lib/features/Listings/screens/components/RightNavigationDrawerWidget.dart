import 'package:flutter/material.dart';

import 'package:best_deals/features/Filters/screens/ListFilterWidget.dart';
import 'package:best_deals/features/Listings/screens/components/CollectionsWidget.dart';

class RightNavigationDrawerWidget extends StatelessWidget {
  const RightNavigationDrawerWidget({
    Key? key,
    required this.categoryCollections,
    required this.rightDrawerName,
    required this.allProductList,
  }) : super(key: key);

  final String rightDrawerName;
  final List categoryCollections;
  final List allProductList;

  @override
  Widget build(BuildContext context) {
    switch (rightDrawerName) {
      case 'collections':
        break;
      case 'icons':
        break;
      case 'filter':
        return ListFilterWidget(
            categoryCollections: categoryCollections,
            allProductList: allProductList);
    }
    return CollectionsWidget(categoryCollections: categoryCollections);
  }
}
