import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:best_deals/common/services/ShopifyCollection/CollectionDetails.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyQueries.dart';
import 'package:best_deals/common/services/ShopifyQueries/ShopifyGQLConfigurations.dart';

class CollectionsWidget extends StatefulWidget {
  const CollectionsWidget({
    Key? key,
    required this.categoryCollections,
  }) : super(key: key);

  final List categoryCollections;

  @override
  State<CollectionsWidget> createState() => _CollectionsWidgetState();
}

class _CollectionsWidgetState extends State<CollectionsWidget> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: widget.categoryCollections.map((categoryCollection) {
              Map collectionDetails = CollectionDetails(categoryCollection);
              return Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      buildMenuItem(
                        text: collectionDetails['collectionTitle'],
                        icon:
                            MdiIcons.fromString(collectionDetails['iconName']),
                        //onClicked: () => getFilterProductData
                        onClicked: () => loadCollectionProducts(
                            context, collectionDetails['handleName']),
                      )
                    ],
                  ),
                ],
              );
            }).toList()),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      hoverColor: Colors.grey[350],
      onTap: onClicked,
    );
  }

  Future<void> loadCollectionProducts(
      BuildContext context, String handleName) async {
    Queries query = Queries();
    ShopifyGQLConfigurations dealsListingQuery = ShopifyGQLConfigurations();
    ShopifyGQLConfigurations collectionListingQuery =
        ShopifyGQLConfigurations();

    List productListRaw = [];
    List collectionList = [];

    List productListDeal = [];

    await dealsListingQuery.fetchShopifyGraphqlQuery(
        query.fetchCollectionByHandle(handleName), 'collectionByHandle');
    productListRaw = dealsListingQuery.shopifyQueryResult!;
    productListRaw.forEach((product) {
      String productType = product['node']['productType'];
      if (productType.trim() == 'deal') {
        productListDeal.add(product);
      }
    });

    String collectionQueryArgument = 'first:10, reverse: true';
    await collectionListingQuery.fetchShopifyGraphqlQuery(
        query.fetchCollection(collectionQueryArgument), 'collection');
    collectionList = collectionListingQuery.shopifyQueryResult!;

    if (productListDeal.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed('/listings', arguments: {
        'productList': productListDeal,
        'collectionList': collectionList
      });
    }
  }
}
