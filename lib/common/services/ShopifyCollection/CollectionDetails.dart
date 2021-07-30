Map CollectionDetails(shopifyCollection) {
  var collectionDetails = new Map();

  String collectionHandle = shopifyCollection['node']['handle'];
  String collectionTitle = shopifyCollection['node']['title'];
  String collectionDescription = shopifyCollection['node']['description'];

  int indexOfIcon = collectionDescription.indexOf(RegExp(r'icon'));
  int indexOfInfo = collectionDescription.indexOf('[info]');
  String iconDescription =
      collectionDescription.substring(indexOfIcon, indexOfInfo);
  String iconName =
      (iconDescription.split('=')[1].replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
  collectionDetails['handleName'] = collectionHandle;
  collectionDetails['collectionTitle'] = collectionTitle;
  collectionDetails['iconName'] = iconName;

  return collectionDetails;
}
