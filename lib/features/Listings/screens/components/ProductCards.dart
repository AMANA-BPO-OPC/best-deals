import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:best_deals/common/services/ShopifyProduct/ProductDetails.dart';

class ProductsCard extends StatefulWidget {
  const ProductsCard(
      {Key? key,
      required this.shopifyProducts,
      required this.index,
      required this.shopifyIds})
      : super(key: key);

  final List shopifyProducts;
  final int index;
  final List<String> shopifyIds;

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  List<String> productIds = [];
  bool doSavePreference = false;

  Future<void> saveProductPreferences(List<String> productIds) async {
    print('save product preferences');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('sample1', productIds);
  }

  @override
  Widget build(BuildContext context) {
    Map productDetails = ProductDetails(widget.shopifyProducts, widget.index);
    List iconNames = productDetails['iconNames'];

    if (doSavePreference) {
      saveProductPreferences(productIds);
    }

    return Card(
      child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/loadingDealDetail',
                arguments: {'productDetails': productDetails});
          },
          leading: Image(
            image: NetworkImage(productDetails['productMainImage']),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(productDetails['title']),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                    child: Text(
                      productDetails['comparePriceCurrencyCode'] +
                          productDetails['comparePrice'],
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    child: Text(
                      productDetails['currentPriceCurrencyCode'] +
                          productDetails['currentPrice'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(productDetails['discountPercentage'] + '%')
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    child: Text(productDetails['vendor']),
                  ),
                  Text(
                    productDetails['productExpiration'],
                    style: TextStyle(
                        color: Colors.white, backgroundColor: Colors.black),
                  )
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: iconNames.map((iconName) {
                    if (iconName == 'settings') {
                      return IconButton(
                        onPressed: () {
                          setState(() {
                            productIds.add(productDetails['title']);
                            doSavePreference = true;
                          });
                        },
                        icon: Icon(MdiIcons.fromString('cog-outline')),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {},
                        icon: Icon(MdiIcons.fromString(iconName)),
                      );
                    }
                  }).toList()),
            ],
          )),
    );
  }
}
