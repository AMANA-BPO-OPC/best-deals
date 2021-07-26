import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:best_deals/features/Listings/services/ProductDetails.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard(
      {Key? key, required this.shopifyProducts, required this.index})
      : super(key: key);

  final List shopifyProducts;
  final int index;

  @override
  Widget build(BuildContext context) {
    Map productDetails = ProductDetails(shopifyProducts, index);
    List iconNames = productDetails['iconNames'];

    return Card(
      child: ListTile(
          onTap: () {},
          leading: Image(
            image: NetworkImage(productDetails['image']),
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
                    return IconButton(
                      onPressed: () {},
                      icon: Icon(MdiIcons.fromString(iconName)),
                    );
                  }).toList()),
            ],
          )),
    );
  }
}
