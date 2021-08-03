class Queries {
  String fetchProducts(queryArgument) {
    return '''
      query {
        products($queryArgument) {
          edges {
            cursor,
            node {
              id,
              title,
              createdAt,
              productType,
              vendor,
              description,
              tags,
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

  String fetchPosts() {
    return '''
      query {
        products(first:2, reverse: true, sortKey: CREATED_AT, query:"product_type:post") {
          edges {
            cursor,
            node {
              id,
              title,
              createdAt,
              productType,
              vendor,
              description,
              tags,
              images(first:250){
                edges{
                  node{
                    originalSrc
                  }
                }
              }
              collections(first:250){
                edges{
                  node{
                    title,
                    description,
                    image{
                      originalSrc
                    }
                  }
                }
              }
            }
          }
        }
      }
    ''';
  }

  String fetchPostsAfter(cursor) {
    return '''
      query {
        products(first:2, reverse: true, sortKey: CREATED_AT, query:"product_type:post", after:"$cursor") {
          edges {
            cursor,
            node {
              id,
              title,
              createdAt,
              productType,
              vendor,
              description,
              tags,
              images(first:250){
                edges{
                  node{
                    originalSrc
                  }
                }
              }
              collections(first:250){
                edges{
                  node{
                    title,
                    description,
                    image{
                      originalSrc
                    }
                  }
                }
              }
            }
          }
        }
      }
    ''';
  }

  String fetchCollection(collectionQueryArgument) {
    return '''
      query {
        collections($collectionQueryArgument){
          edges{
            node{
              handle,
              title,
              description,
              image{
                originalSrc
              }
            }
          }
        }
      }
    ''';
  }

  String fetchCollectionByHandle(handleName) {
    return '''
      query {
        collectionByHandle(handle: "$handleName") {
          products(first:5, sortKey: CREATED, reverse:true) {
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
      }
    ''';
  }
}
