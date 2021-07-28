Map ProductDetails(shopifyProducts, index) {
  var productDetails = new Map();
  String productCursor = shopifyProducts[index]['cursor'];
  String productId = shopifyProducts[index]['node']['id'];
  String title = shopifyProducts[index]['node']['title'];
  String vendor = shopifyProducts[index]['node']['vendor'];

  List<String> productImages = [];
  List productImagesList = shopifyProducts[index]['node']['images']['edges'];
  productImagesList.forEach((image) {
    productImages.add(image['node']['originalSrc']);
  });

  String productMainImage = productImages[0];

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
  iconNames.add('settings');

  String productDescription = shopifyProducts[index]['node']['description'];
  int indexOfInfo = productDescription.indexOf('[info]');
  print('DESCIPTION');
  print(productDescription);
  //EXTRACT EXPIRATION TIME IN PRODUCT DESCRIPTION
  int indexOfExpiration = productDescription.indexOf(RegExp('expiration'));
  String productExpirationDescription =
      productDescription.substring(indexOfExpiration, indexOfInfo);
  String productExpiration = productExpirationDescription.split('=')[1];

  //EXTRACT URL IN PRODUCT DESCRIPTION
  int indexOfUrl = productDescription.indexOf(RegExp('url'));
  String productUrlDescription =
      productDescription.substring(indexOfUrl, indexOfExpiration);
  String productUrl = productUrlDescription.split('=')[1];

  //EXTRACT PRODUCT INFO IN PRODUCT DESCRIPTION
  String productInfoDescription = productDescription.substring(indexOfInfo);
  String productInfo = productInfoDescription.split('[info]')[1].trim();

  productDetails['productCursor'] = productCursor;
  productDetails['productId'] = productId;
  productDetails['title'] = title;
  productDetails['vendor'] = vendor;
  productDetails['productImages'] = productImages;
  productDetails['productMainImage'] = productMainImage;
  productDetails['comparePrice'] = comparePrice;
  productDetails['comparePriceCurrencyCode'] = comparePriceCurrencyCode;
  productDetails['currentPrice'] = currentPrice;
  productDetails['currentPriceCurrencyCode'] = currentPriceCurrencyCode;
  productDetails['discountPercentage'] = discountPercentage.toInt().toString();
  productDetails['iconNames'] = iconNames;
  productDetails['productExpiration'] = productExpiration;
  productDetails['productUrl'] = productUrl;
  productDetails['productInfo'] = productInfo;

  return productDetails;
}
