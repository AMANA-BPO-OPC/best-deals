class Queries {
  String fetchProducts() {
    return '''
      query {
        products(first:6,sortKey: CREATED_AT,reverse:true) {
          edges {
            cursor,
            node {
              id,
              title,
              createdAt,
              productType,
              vendor,
              description,
              images(first:250){
                edges{
                  node{
                    originalSrc
                  }
                }
              }
              variants(first:1) {
                edges {
                  node {
                    id,
                    priceV2{
                      amount,
                      currencyCode
                    }
                    compareAtPriceV2{
                      amount,
                      currencyCode
                    }
                  }
                }
              }
              collections(first:250){
                edges{
                  node{
                    title,
                    description
                  }
                }
              }
            }
          }
        }
      }
    ''';
  }

  String fetchProductsAfter(cursor) {
    return '''
      query {
        products(first:2,sortKey: CREATED_AT,reverse:true,after:"$cursor") {
          edges {
            cursor,
            node {
              id,
              title,
              createdAt,
              productType,
              vendor,
              description,
              images(first:250){
                edges{
                  node{
                    originalSrc
                  }
                }
              }
              variants(first:1) {
                edges {
                  node {
                    id,
                    priceV2{
                      amount,
                      currencyCode
                    }
                    compareAtPriceV2{
                      amount,
                      currencyCode
                    }
                  }
                }
              }
              collections(first:250){
                edges{
                  node{
                    title,
                    description
                  }
                }
              }
            }
          }
        }
      }
    ''';
  }

  String fetchProductsBefore(cursor) {
    return '''
      query {
        products(last:1, reverse: true, sortKey: CREATED_AT, before:"$cursor") {
          edges {
            cursor,
            node {
              id,
              title,
              createdAt,
              productType,
              vendor,
              description,
              images(first:250){
                edges{
                  node{
                    originalSrc
                  }
                }
              }
              variants(first:1) {
                edges {
                  node {
                    id,
                    priceV2{
                      amount,
                      currencyCode
                    }
                    compareAtPriceV2{
                      amount,
                      currencyCode
                    }
                  }
                }
              }
              collections(first:250){
                edges{
                  node{
                    title,
                    description
                  }
                }
              }
            }
          }
        }
      }
    ''';
  }
}
