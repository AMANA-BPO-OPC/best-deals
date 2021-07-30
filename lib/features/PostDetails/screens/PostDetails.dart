import 'package:flutter/material.dart';

import 'package:best_deals/features/PostDetails/screens/components/PostPersonCollectionDetails.dart';

class PostDetails extends StatefulWidget {
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    Map dealDetails = ModalRoute.of(context)!.settings.arguments as Map;

    String postMainImage =
        dealDetails['postDetails']['postDetails']['productMainImage'];
    String postTitle = dealDetails['postDetails']['postDetails']['title'];
    String postDescription =
        dealDetails['postDetails']['postDetails']['postInfo'];
    List postPersonCollection =
        dealDetails['postDetails']['postDetails']['personCollection'];
    List postAllCollection =
        dealDetails['postDetails']['postDetails']['postAllCollection'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.network(
              postMainImage,
              fit: BoxFit.fitWidth,
              width: 500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              children: postPersonCollection.map((collection) {
                return PostPersonCollectionDetails(
                  collectionTitle: collection['node']['title'],
                  collectionImage: collection['node']['image']['originalSrc'],
                  collectionDescription: collection['node']['description'],
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              postTitle,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  postDescription,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: Text(
                  'Checkout these links',
                  style: TextStyle(fontSize: 18.0),
                )),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey[800]),
                  onPressed: () {},
                  child: Text('Go to article'),
                ),
              )
            ],
          ),
          Row(
              children: postAllCollection.map((collection) {
            String collectionImage = collection['node']['image']['originalSrc'];
            return IconButton(
              iconSize: 35.0,
              onPressed: () {},
              icon: Image.network(collectionImage),
            );
          }).toList()),
        ],
      ),
    );
  }
}
