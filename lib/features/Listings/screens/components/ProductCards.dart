import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard(
      {Key? key, required this.shopifyProducts, required this.index})
      : super(key: key);

  final List shopifyProducts;
  final int index;

  Map ProductDetails() {
    var productDetails = new Map();

    String image = shopifyProducts[index]['node']['images']['edges'][0]['node']
        ['originalSrc'];

    String comparePrice = shopifyProducts[index]['node']['variants']['edges'][0]
        ['node']['compareAtPriceV2']['amount'];

    String comparePriceCurrencyCode = shopifyProducts[index]['node']['variants']
        ['edges'][0]['node']['compareAtPriceV2']['currencyCode'];

    String currentPrice = shopifyProducts[index]['node']['variants']['edges'][0]
        ['node']['priceV2']['amount'];

    String currentPriceCurrencyCode = shopifyProducts[index]['node']['variants']
        ['edges'][0]['node']['priceV2']['currencyCode'];

    double intComparePrice = double.parse(comparePrice);
    double intCurrentPrice = double.parse(currentPrice);

    double discountPercentage =
        ((intComparePrice - intCurrentPrice) / intComparePrice) * 100;

    List productCollections =
        shopifyProducts[index]['node']['collections']['edges'];

    productCollections.forEach((collection) {
      print(collection['node']['description']);
      String collectionDescription = collection['node']['description'];
      int indexOfIcon = collectionDescription.indexOf(RegExp(r'icon'));
      int indexOfInfo = collectionDescription.indexOf('[info]');
      String iconDescription =
          collectionDescription.substring(indexOfIcon, indexOfInfo);

      String iconName = (iconDescription
          .split('=')[1]
          .replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
      print(iconName);
    });

    productDetails['image'] = image;
    productDetails['comparePrice'] = comparePrice;
    productDetails['comparePriceCurrencyCode'] = comparePriceCurrencyCode;
    productDetails['currentPrice'] = currentPrice;
    productDetails['currentPriceCurrencyCode'] = currentPriceCurrencyCode;
    productDetails['discountPercentage'] =
        discountPercentage.toInt().toString();

    return productDetails;
  }

  @override
  Widget build(BuildContext context) {
    Map productDetails = ProductDetails();

    return Card(
      child: ListTile(
          onTap: () {},
          leading: Image(
            image: NetworkImage(productDetails['image']),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(shopifyProducts[index]['node']['title']),
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
              Text(shopifyProducts[index]['node']['vendor']),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.fromString('sword')),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(MdiIcons.fromString('tshirt-v')),
                  )
                ],
              )
            ],
          )),
    );
  }
}
