import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class ListingsService {
  List? productsList;
  String? productQueryError;

  Future<void> fetchShopifyProducts() async {
    Queries query = Queries();
    ShopifyGQLConfigurations listingsQuery = ShopifyGQLConfigurations();

    await listingsQuery.fetchShopifyGraphqlQuery(query.fetchProducts());
    productsList = listingsQuery.shopifyQueryResult;
    productQueryError = listingsQuery.queryError;
  }
}
