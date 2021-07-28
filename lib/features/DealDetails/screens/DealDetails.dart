import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DealDetails extends StatefulWidget {
  @override
  _DealDetailsState createState() => _DealDetailsState();
}

class _DealDetailsState extends State<DealDetails> {
  @override
  Widget build(BuildContext context) {
    Map dealDetails = ModalRoute.of(context)!.settings.arguments as Map;
    List productImages =
        dealDetails['productDetails']['productDetails']['productImages'];
    List iconNames =
        dealDetails['productDetails']['productDetails']['iconNames'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deal Details'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(''),
          Card(
            color: Colors.black,
            child: CarouselSlider(
              items: productImages
                  .map(
                    (image) => Container(
                      child: Image.network(
                        image,
                        fit: BoxFit.fitHeight,
                        width: 500,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true, aspectRatio: 2.0, enlargeCenterPage: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 20.0),
            child: Center(
              child: Text(
                dealDetails['productDetails']['productDetails']
                    ['productExpiration'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
          ),
          Text(
            dealDetails['productDetails']['productDetails']['title'],
            style: TextStyle(fontSize: 20.0),
          ),
          Row(
            children: <Widget>[
              Text('Price: ', style: TextStyle(fontSize: 20.0)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                child: Text(
                  dealDetails['productDetails']['productDetails']
                          ['comparePriceCurrencyCode'] +
                      dealDetails['productDetails']['productDetails']
                          ['comparePrice'],
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Text(
                  dealDetails['productDetails']['productDetails']
                          ['currentPriceCurrencyCode'] +
                      dealDetails['productDetails']['productDetails']
                          ['currentPrice'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Text(
                dealDetails['productDetails']['productDetails']
                        ['discountPercentage'] +
                    '%',
                style: TextStyle(
                    backgroundColor: Colors.grey[400], fontSize: 20.0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
            child: Text(
              'Shop: ' +
                  dealDetails['productDetails']['productDetails']['vendor'],
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Text(
            dealDetails['productDetails']['productDetails']['productInfo'],
            style: TextStyle(fontSize: 20.0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
            child: const Text('Attributes', style: TextStyle(fontSize: 20.0)),
          ),
          Row(
              children: iconNames.map((iconName) {
            return IconButton(
              onPressed: () {},
              iconSize: 30.0,
              icon: Icon(MdiIcons.fromString(iconName)),
            );
          }).toList()),
          Card(
            color: Colors.grey[350],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loadingDealDetail',
                          arguments: {
                            'productDetails': dealDetails['productBefore']
                          });
                    },
                    iconSize: 60.0,
                    icon: Icon(Icons.arrow_left)),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Go To Shop',
                      style: TextStyle(fontSize: 20.0),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/loadingDealDetail',
                          arguments: {
                            'productDetails': dealDetails['productAfter']
                          });
                    },
                    iconSize: 60.0,
                    icon: Icon(Icons.arrow_right)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
