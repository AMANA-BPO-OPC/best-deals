import 'package:flutter/material.dart';

class ListFilterWidget extends StatefulWidget {
  const ListFilterWidget({
    Key? key,
    required this.shopifyProducts,
  }) : super(key: key);

  final List shopifyProducts;

  @override
  State<ListFilterWidget> createState() => _ListFilterWidgetState();
}

class _ListFilterWidgetState extends State<ListFilterWidget> {
  bool isShopFilterShow = false;
  bool isPriceRangeFilterShow = false;
  bool isLocationFilterShow = false;
  bool isTypeFilterShow = false;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    List shopifyProducts = widget.shopifyProducts;
    List shopNames = [];

    shopifyProducts.forEach((shopifyProducts) {
      shopNames.add(shopifyProducts['node']['vendor']);
    });
    shopNames = shopNames.toSet().toList();
    print(shopNames);
    return Drawer(
      child: Material(
          child: ListView(
        children: [
          Column(
            children: <Widget>[
              ListTile(
                title: Center(
                  child: Text(
                    'Shop',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                hoverColor: Colors.grey[600],
                tileColor: Colors.grey[850],
                onTap: () =>
                    setState(() => isShopFilterShow = !isShopFilterShow),
              ),
              Visibility(
                visible: isShopFilterShow,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Shop Name'),
                      Text('Shop Name Lain'),
                      Text('Shop Name Lain Napud'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2),
              ListTile(
                title: Center(
                  child: Text(
                    'Price Range',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                hoverColor: Colors.grey[600],
                tileColor: Colors.grey[850],
                onTap: () => setState(
                    () => isPriceRangeFilterShow = !isPriceRangeFilterShow),
              ),
              Visibility(
                visible: isPriceRangeFilterShow,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('Minimum'), Text('Maximum')],
                  ),
                ),
              ),
              SizedBox(height: 2),
              ListTile(
                title: Center(
                  child: Text(
                    'Location',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                hoverColor: Colors.grey[600],
                tileColor: Colors.grey[850],
                onTap: () => setState(
                    () => isLocationFilterShow = !isLocationFilterShow),
              ),
              Visibility(
                visible: isLocationFilterShow,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('US'), Text('Saudi Arabia')],
                  ),
                ),
              ),
              SizedBox(height: 2),
              ListTile(
                title: Center(
                  child: Text(
                    'Type',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                hoverColor: Colors.grey[600],
                tileColor: Colors.grey[850],
                onTap: () =>
                    setState(() => isTypeFilterShow = !isTypeFilterShow),
              ),
              Visibility(
                visible: isTypeFilterShow,
                child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('Deals'), Text('Posts')],
                  ),
                ),
              ),
            ],
          )
        ],
      )
          // child: ListView(
          //   children: listFilters.map((listFilter) {
          //   return Column(
          //     children: <Widget>[
          //       ListTile(
          //         title: Text(listFilter),
          //         hoverColor: Colors.grey[300],
          //         onTap: () {
          //           print('jude gwapo');
          //         },
          //       ),
          //     ],
          //   );
          // }).toList()),
          ),
    );
  }
}
