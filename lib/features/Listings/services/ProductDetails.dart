Map ProductDetails(shopifyProducts, index) {
  var productDetails = new Map();

  String title = shopifyProducts[index]['node']['title'];
  String vendor = shopifyProducts[index]['node']['vendor'];

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

  List iconNames = [];
  productCollections.forEach((collection) {
    String collectionDescription = collection['node']['description'];
    int indexOfIcon = collectionDescription.indexOf(RegExp(r'icon'));
    int indexOfInfo = collectionDescription.indexOf('[info]');
    String iconDescription =
        collectionDescription.substring(indexOfIcon, indexOfInfo);

    String iconName = (iconDescription
        .split('=')[1]
        .replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
    iconNames.add(iconName);
  });

  String productDescription = shopifyProducts[index]['node']['description'];
  int indexOfExpiration = productDescription.indexOf(RegExp('expiration'));
  int indexOfIcon = productDescription.indexOf('[info]');
  String productExpirationDescription =
      productDescription.substring(indexOfExpiration, indexOfIcon);
  String productExpiration = productExpirationDescription.split('=')[1];

  productDetails['title'] = title;
  productDetails['vendor'] = vendor;
  productDetails['image'] = image;
  productDetails['comparePrice'] = comparePrice;
  productDetails['comparePriceCurrencyCode'] = comparePriceCurrencyCode;
  productDetails['currentPrice'] = currentPrice;
  productDetails['currentPriceCurrencyCode'] = currentPriceCurrencyCode;
  productDetails['discountPercentage'] = discountPercentage.toInt().toString();
  productDetails['iconNames'] = iconNames;
  productDetails['productExpiration'] = productExpiration;

  return productDetails;
}
