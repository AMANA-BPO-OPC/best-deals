import 'package:best_deals/features/Filters/services/CheckBoxState.dart';

void getShopNamesChecked(shopNamesCheck, allProducts) {
  if (shopNamesCheck.isEmpty) {
    List shopNames = [];

    for (var allProducts in allProducts) {
      shopNames.add(allProducts['node']['vendor']);
    }
    shopNames = shopNames.toSet().toList();

    int index = 0;
    shopNames.forEach((shopName) {
      shopNamesCheck
          .add(CheckBoxState(title: shopName, index: index, value: false));
      index++;
    });
  }
}

void getLocationNamesChecked(locationNamesCheck, allProducts) {
  if (locationNamesCheck.isEmpty) {
    List locationNames = [];

    for (var allProducts in allProducts) {
      List productTags = allProducts['node']['tags'];
      productTags.forEach((productTag) {
        if (productTag.contains(RegExp('location'))) {
          locationNames.add(productTag.split('=')[1]);
        }
      });
    }
    locationNames = locationNames.toSet().toList();

    int index = 0;
    locationNames.forEach((locationName) {
      locationNamesCheck
          .add(CheckBoxState(title: locationName, index: index, value: false));
      index++;
    });
  }
}

void getTypeNamesChecked(typeNamesCheck, allProducts) {
  if (typeNamesCheck.isEmpty) {
    List typeNames = ['Deal', 'Post'];
    int index = 0;
    typeNames.forEach((typeName) {
      if (typeName == 'Deal') {
        typeNamesCheck
            .add(CheckBoxState(title: typeName, index: index, value: true));
      } else {
        typeNamesCheck
            .add(CheckBoxState(title: typeName, index: index, value: false));
      }
      index++;
    });
  }
}

List getShopFilters(shopNamesCheck) {
  List shopFilters = [];
  shopNamesCheck.forEach((shop) {
    if (shop.value) {
      shopFilters.add(shop.title);
    }
  });
  return shopFilters;
}

List getLocationFilters(locationNamesCheck) {
  List locationFilters = [];
  locationNamesCheck.forEach((location) {
    if (location.value) {
      locationFilters.add(location.title);
    }
  });
  return locationFilters;
}

List getTypeFilters(typeNamesCheck) {
  List typeFilters = [];
  typeNamesCheck.forEach((type) {
    if (type.value) {
      typeFilters.add(type.title);
    }
  });
  return typeFilters;
}
