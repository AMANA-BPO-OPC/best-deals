import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:best_deals/common/model/ShopifyGraphql/GQLClient.dart';

class ShopifyGQLConfigurations {
  final GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  List? shopifyQueryResult;
  String? queryError;

  //FETCH SHOPIFY GRAPHQL QUERY
  Future fetchShopifyGraphqlQuery(String shopifyGQLQuery) async {
    GraphQLClient _client = _graphQLConfiguration.myGQLClient();
    QueryResult result =
        await _client.query(QueryOptions(document: gql(shopifyGQLQuery)));
    if (result.hasException) {
      queryError = result.exception.toString();
    } else if (!result.hasException) {
      shopifyQueryResult = result.data['products']['edges'];
    }
  }
}
