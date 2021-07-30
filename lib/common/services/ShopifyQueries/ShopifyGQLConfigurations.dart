import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:best_deals/common/model/ShopifyGraphql/GQLClient.dart';

class ShopifyGQLConfigurations {
  final GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  List? shopifyQueryResult;
  String? queryError;

  //FETCH SHOPIFY GRAPHQL QUERY
  Future fetchShopifyGraphqlQuery(
      String shopifyGQLQuery, String queryName) async {
    GraphQLClient _client = _graphQLConfiguration.myGQLClient();
    QueryResult result =
        await _client.query(QueryOptions(document: gql(shopifyGQLQuery)));
    if (result.hasException) {
      print('EXCEPTION');
      queryError = result.exception.toString();
    } else if (!result.hasException) {
      if (queryName == 'product') {
        shopifyQueryResult = result.data['products']['edges'];
      } else if (queryName == 'collection') {
        shopifyQueryResult = result.data['collections']['edges'];
      } else if (queryName == 'collectionByHandle') {
        shopifyQueryResult =
            result.data['collectionByHandle']['products']['edges'];
      }
    }
  }
}
