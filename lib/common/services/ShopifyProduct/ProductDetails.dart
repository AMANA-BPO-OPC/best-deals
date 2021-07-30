Map ProductDetails(shopifyProducts, index) {
  var productDetails = new Map();

  String productCursor = shopifyProducts[index]['cursor'];
  String productId = shopifyProducts[index]['node']['id'];
  String title = shopifyProducts[index]['node']['title'];
  String vendor = shopifyProducts[index]['node']['vendor'];
  String productType = shopifyProducts[index]['node']['productType'];
  List<String> productImages = [];
  List productImagesList = shopifyProducts[index]['node']['images']['edges'];
  productImagesList.forEach((image) {
    productImages.add(image['node']['originalSrc']);
  });

  String productMainImage = productImages[0];

  String productDescription = shopifyProducts[index]['node']['description'];
  int indexOfInfo = productDescription.indexOf('[info]');

  //EXTRACT PRODUCT INFO IN PRODUCT DESCRIPTION
  String productInfoDescription = productDescription.substring(indexOfInfo);
  String productInfo = productInfoDescription.split('[info]')[1].trim();

  List productCollections =
      shopifyProducts[index]['node']['collections']['edges'];

  List productTags = shopifyProducts[index]['node']['tags'];
  switch (productType) {
    case "deal":
      String comparePrice = shopifyProducts[index]['node']['variants']['edges']
          [0]['node']['compareAtPriceV2']['amount'];

      String comparePriceCurrencyCode = shopifyProducts[index]['node']
          ['variants']['edges'][0]['node']['compareAtPriceV2']['currencyCode'];

      String currentPrice = shopifyProducts[index]['node']['variants']['edges']
          [0]['node']['priceV2']['amount'];

      String currentPriceCurrencyCode = shopifyProducts[index]['node']
          ['variants']['edges'][0]['node']['priceV2']['currencyCode'];

      double intComparePrice = double.parse(comparePrice);
      double intCurrentPrice = double.parse(currentPrice);

      double discountPercentage =
          ((intComparePrice - intCurrentPrice) / intComparePrice) * 100;

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

      productDetails['comparePrice'] = comparePrice;
      productDetails['comparePriceCurrencyCode'] = comparePriceCurrencyCode;
      productDetails['currentPrice'] = currentPrice;
      productDetails['currentPriceCurrencyCode'] = currentPriceCurrencyCode;
      productDetails['discountPercentage'] =
          discountPercentage.toInt().toString();
      productDetails['iconNames'] = iconNames;
      productDetails['productExpiration'] = productExpiration;
      productDetails['productUrl'] = productUrl;
      productDetails['productInfo'] = productInfo;

      break;
    case "post":
      //EXTRACT ARTICLE ID IN PRODUCT DESCRIPTION
      int indexOfArticleId = productDescription.indexOf(RegExp('article_id'));
      String postArticleIdDescription =
          productDescription.substring(indexOfArticleId, indexOfInfo);
      String postArticleId = postArticleIdDescription.split('=')[1];

      //EXTRACT POST INFO IN PRODUCT DESCRIPTION
      String postInfoDescription = productDescription.substring(indexOfInfo);
      String postInfo = postInfoDescription.split('[info]')[1].trim();

      String postDateCreated = shopifyProducts[index]['node']['createdAt'];
      String postAuthor = 'Anonymous';

      productTags.forEach((productTag) {
        if (productTag.contains(RegExp('author'))) {
          int indexOfAuthor = productTag.indexOf('author');
          String postAuthorDescription = productTag.substring(indexOfAuthor);
          postAuthor = postAuthorDescription.split(':')[1].trim();
        }
      });

      List personCollection = [];
      productCollections.forEach((collection) {
        if (collection['node']['description']
            .replaceAll(new RegExp(r"\s+\b|\b\s"), "")
            .contains(RegExp('type=person'))) {
          personCollection.add(collection);
        }
      });

      productDetails['postArticleId'] = postArticleId;
      productDetails['postInfo'] = postInfo;
      productDetails['author'] = postAuthor;
      productDetails['postDateCreated'] = postDateCreated;
      productDetails['postInfo'] = productInfo;
      productDetails['personCollection'] = personCollection;
      productDetails['postAllCollection'] = productCollections;

      break;
  }

  productDetails['productCursor'] = productCursor;
  productDetails['productId'] = productId;
  productDetails['title'] = title;
  productDetails['vendor'] = vendor;
  productDetails['productImages'] = productImages;
  productDetails['productMainImage'] = productMainImage;

  return productDetails;
}
