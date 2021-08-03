import 'package:flutter/material.dart';

import 'package:best_deals/features/Filters/services/FilterListQuery.dart';
import 'package:best_deals/features/Filters/services/CheckBoxState.dart';
import 'package:best_deals/features/Filters/services/CheckBoxListFilters.dart';

class ListFilterWidget extends StatefulWidget {
  const ListFilterWidget({
    Key? key,
    required this.categoryCollections,
    required this.allProductList,
  }) : super(key: key);

  final List categoryCollections;
  final List allProductList;

  @override
  State<ListFilterWidget> createState() => _ListFilterWidgetState();
}

class _ListFilterWidgetState extends State<ListFilterWidget> {
  bool isShopFilterShow = false;
  bool isPriceRangeFilterShow = false;
  bool isLocationFilterShow = false;
  bool isTypeFilterShow = false;

  bool firstLoading = true;
  List<CheckBoxState> shopNamesCheck = [];
  List<CheckBoxState> locationNamesCheck = [];
  List<CheckBoxState> typeNamesCheck = [];

  final minumumPriceController = TextEditingController();
  final maximumPriceController = TextEditingController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    List allProducts = widget.allProductList;
    List categoryCollections = widget.categoryCollections;

    if (firstLoading) {
      getShopNamesChecked(shopNamesCheck, allProducts);
      getLocationNamesChecked(locationNamesCheck, allProducts);
      getTypeNamesChecked(typeNamesCheck, allProducts);
    }

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: shopNamesCheck.map((shop) {
                        int shopIndex = shop.index;
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.blue,
                            value: shop.value,
                            title: Text(shop.title),
                            onChanged: (value) {
                              setState(() {
                                firstLoading = false;
                                shopNamesCheck[shopIndex].value = value!;
                              });
                            });
                      }).toList())),
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
                    children: <Widget>[
                      TextField(
                        controller: minumumPriceController,
                        decoration: InputDecoration(
                            labelText: 'Minimum Price', hintText: '0.00'),
                      ),
                      TextField(
                        controller: maximumPriceController,
                        decoration: InputDecoration(
                            labelText: 'Maximum Price', hintText: '0.00'),
                      )
                    ],
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: locationNamesCheck.map((location) {
                        int locationIndex = location.index;
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.blue,
                            value: location.value,
                            title: Text(location.title),
                            onChanged: (value) {
                              setState(() {
                                firstLoading = false;
                                locationNamesCheck[locationIndex].value =
                                    value!;
                              });
                            });
                      }).toList())),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: typeNamesCheck.map((type) {
                        int typeIndex = type.index;
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.blue,
                            value: type.value,
                            title: Text(type.title),
                            onChanged: (value) {
                              setState(() {
                                firstLoading = false;
                                typeNamesCheck[typeIndex].value = value!;
                              });
                            });
                      }).toList())),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () => filterDeals(
                      context,
                      shopNamesCheck,
                      locationNamesCheck,
                      typeNamesCheck,
                      minumumPriceController.text,
                      maximumPriceController.text,
                      allProducts,
                      categoryCollections),
                  child: const Text('Filter'))
            ],
          )
        ],
      )),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.blue,
        value: checkbox.value,
        title: Text(checkbox.title),
        onChanged: (value) {
          setState(() {
            firstLoading = false;
            checkbox.value = !value!;
            //shopNames = shopNamesCheck;
          });
        });
  }
}
