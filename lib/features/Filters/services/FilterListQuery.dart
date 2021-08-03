import 'package:flutter/material.dart';

import 'package:best_deals/features/Filters/services/CheckBoxListFilters.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

Future<void> filterDeals(
    context,
    shopNamesCheck,
    locationNamesCheck,
    typeNamesCheck,
    minimumPrice,
    maximumPrice,
    allProducts,
    categoryCollections) async {
  Queries query = Queries();
  ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();

  List shopFilters = getShopFilters(shopNamesCheck);
  List locationFilters = getLocationFilters(locationNamesCheck);
  List typeFilters = getTypeFilters(typeNamesCheck);

  String filterArgument = getFilterArgument(
      typeFilters, shopFilters, locationFilters, minimumPrice, maximumPrice);

  String queryArgument =
      'first:5,sortKey: CREATED_AT, reverse:true, query:"$filterArgument"';

  print(queryArgument);

  await listingsQuery.fetchShopifyGraphqlQuery(
      query.fetchProducts(queryArgument), 'product');

  Navigator.of(context).pushReplacementNamed('/listings', arguments: {
    'allProductList': allProducts,
    'productList': listingsQuery.shopifyQueryResult!,
    'collectionList': categoryCollections,
  });
}

String getFilterArgument(
    typeFilters, shopFilters, locationFilters, minimumPrice, maximumPrice) {
  String filterArgument = '';
  if (typeFilters.isNotEmpty) {
    filterArgument += '(';
    int typeIndex = 1;
    typeFilters.forEach((typeFilter) {
      String typeFilterLower = typeFilter.toLowerCase();
      filterArgument += 'product_type:$typeFilterLower';

      if (typeIndex != typeFilters.length) {
        filterArgument += ' OR ';
      }

      if (typeIndex == typeFilters.length) {
        filterArgument += ')';
      }
      typeIndex++;
    });
    if (shopFilters.isNotEmpty) {
      filterArgument += ' AND ';
      filterArgument += '(';
      int shopIndex = 1;
      shopFilters.forEach((shopFilter) {
        filterArgument += 'vendor:$shopFilter';

        if (shopIndex != shopFilters.length) {
          filterArgument += ' OR ';
        }

        if (shopIndex == shopFilters.length) {
          filterArgument += ')';
        }
        shopIndex++;
      });
    }
    if (locationFilters.isNotEmpty) {
      filterArgument += ' AND ';
      filterArgument += '(';
      int locationIndex = 1;
      locationFilters.forEach((locationFilter) {
        filterArgument += 'tag:location=$locationFilter';

        if (locationIndex != locationFilters.length) {
          filterArgument += ' OR ';
        }

        if (locationIndex == locationFilters.length) {
          filterArgument += ')';
        }
        locationIndex++;
      });
    }
    if (minimumPrice != '') {
      filterArgument += ' AND ';
      filterArgument += '(';
      filterArgument += 'variants.price:>=$minimumPrice';
      if (maximumPrice != '') {
        filterArgument += ' AND ';
        filterArgument += 'variants.price:<=$maximumPrice)';
      } else {
        filterArgument += ')';
      }
    }
    if (maximumPrice != '') {
      filterArgument += ' AND ';
      filterArgument += '(';
      filterArgument += 'variants.price:<=$maximumPrice';
      if (minimumPrice != '') {
        filterArgument += ' AND ';
        filterArgument += 'variants.price:>=$minimumPrice)';
      } else {
        filterArgument += ')';
      }
    }
  } else if (shopFilters.isNotEmpty) {
    filterArgument += '(';
    int shopIndex = 1;
    shopFilters.forEach((shopFilter) {
      filterArgument += 'vendor:$shopFilter';

      if (shopIndex != shopFilters.length) {
        filterArgument += ' OR ';
      }

      if (shopIndex == shopFilters.length) {
        filterArgument += ')';
      }
      shopIndex++;
    });
    if (locationFilters.isNotEmpty) {
      filterArgument += ' AND ';
      filterArgument += '(';
      int locationIndex = 1;
      locationFilters.forEach((locationFilter) {
        filterArgument += 'tag:location=$locationFilter';

        if (locationIndex != locationFilters.length) {
          filterArgument += ' OR ';
        }

        if (locationIndex == locationFilters.length) {
          filterArgument += ')';
        }
        locationIndex++;
      });
    }
    if (minimumPrice != '') {
      filterArgument += ' AND ';
      filterArgument += '(';
      filterArgument += 'variants.price:>=$minimumPrice';
      if (maximumPrice != '') {
        filterArgument += ' AND ';
        filterArgument += 'variants.price:<=$maximumPrice)';
      } else {
        filterArgument += ')';
      }
    }
    if (maximumPrice != '') {
      filterArgument += ' AND ';
      filterArgument += '(';
      filterArgument += 'variants.price:<=$maximumPrice';
      if (minimumPrice != '') {
        filterArgument += ' AND ';
        filterArgument += 'variants.price:>=$minimumPrice)';
      } else {
        filterArgument += ')';
      }
    }
  } else if (locationFilters.isNotEmpty) {
    filterArgument += '(';
    int locationIndex = 1;
    locationFilters.forEach((locationFilter) {
      filterArgument += 'tag:location=$locationFilter';

      if (locationIndex != locationFilters.length) {
        filterArgument += ' OR ';
      }

      if (locationIndex == locationFilters.length) {
        filterArgument += ')';
      }
      locationIndex++;
    });
    if (minimumPrice != '') {
      filterArgument += ' AND ';
      filterArgument += '(';
      filterArgument += 'variants.price:>=$minimumPrice';
      if (maximumPrice != '') {
        filterArgument += ' AND ';
        filterArgument += 'variants.price:<=$maximumPrice)';
      } else {
        filterArgument += ')';
      }
    }
    if (maximumPrice != '') {
      filterArgument += ' AND ';
      filterArgument += '(';
      filterArgument += 'variants.price:<=$maximumPrice';
      if (minimumPrice != '') {
        filterArgument += ' AND ';
        filterArgument += 'variants.price:>=$minimumPrice)';
      } else {
        filterArgument += ')';
      }
    }
  }
  return filterArgument;
}
