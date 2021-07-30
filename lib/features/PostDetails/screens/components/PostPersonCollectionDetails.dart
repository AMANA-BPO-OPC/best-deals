import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostPersonCollectionDetails extends StatelessWidget {
  final collectionTitle;
  final collectionImage;
  final collectionDescription;

  const PostPersonCollectionDetails({
    Key? key,
    required this.collectionTitle,
    required this.collectionImage,
    required this.collectionDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int indexOfSocial = collectionDescription.indexOf('[social]');
    int indexOfInfo = collectionDescription.indexOf('[info]');

    String postPersonSocialDescription =
        collectionDescription.substring(indexOfSocial, indexOfInfo);
    String postPersonSocials =
        postPersonSocialDescription.split('[social]')[1].trim();

    List socials = postPersonSocials.split(' ');

    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(collectionImage),
          radius: 35.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                collectionTitle,
                style: TextStyle(fontSize: 20.0),
              ),
              Row(
                children: socials.map((social) {
                  String socialIcon = '';
                  switch (social.split('=')[0]) {
                    case 'facebook':
                      socialIcon = 'facebook';
                      break;
                    case 'twitter':
                      socialIcon = 'twitter';
                      break;
                    case 'youtube':
                      socialIcon = 'youtube';
                      break;
                    case 'instagram':
                      socialIcon = 'instagram';
                      break;
                  }
                  return IconButton(
                    onPressed: () {
                      print(socialIcon);
                    },
                    icon: Icon(MdiIcons.fromString(socialIcon)),
                  );
                }).toList(),
              )
            ],
          ),
        )
      ],
    );
  }
}
