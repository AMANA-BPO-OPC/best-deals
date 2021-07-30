import 'package:flutter/material.dart';

import 'package:best_deals/common/services/ShopifyProduct/ProductDetails.dart';

class PostsCard extends StatefulWidget {
  const PostsCard({
    Key? key,
    required this.shopifyPosts,
    required this.index,
  }) : super(key: key);

  final List shopifyPosts;
  final int index;

  @override
  State<PostsCard> createState() => _PostsCardState();
}

class _PostsCardState extends State<PostsCard> {
  @override
  Widget build(BuildContext context) {
    Map postDetails = ProductDetails(widget.shopifyPosts, widget.index);
    return Card(
        child: ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/loadingPostDetails',
            arguments: {'postDetails': postDetails});
      },
      leading: Image(
        image: NetworkImage(postDetails['productMainImage']),
      ),
      title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(postDetails['title']),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  postDetails['author'],
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    primary: Colors.grey[400]),
              ),
            ),
            Text(postDetails['postDateCreated']),
          ]),
    ));
  }
}
