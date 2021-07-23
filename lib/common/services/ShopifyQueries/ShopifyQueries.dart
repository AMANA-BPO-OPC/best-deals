class Queries {
  String fetchProducts() {
    return '''
      query {
        products(first:2,sortKey: CREATED_AT,reverse:true) {
          edges {
            node {
              title,
              createdAt,
              productType,
              vendor,
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
