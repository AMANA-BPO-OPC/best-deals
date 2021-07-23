import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  final HttpLink httpLink = HttpLink(
    "https://leadingdeals.myshopify.com/api/2021-07/graphql.json",
    defaultHeaders: {
      "X-Shopify-Storefront-Access-Token": "a546026afb97b241012b3ced9ae80aff"
    },
  );

  GraphQLClient myGQLClient() {
    return GraphQLClient(
        link: httpLink, cache: GraphQLCache(store: InMemoryStore()));
  }
}
