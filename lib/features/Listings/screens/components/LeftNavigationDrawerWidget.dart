import 'package:flutter/material.dart';

class LeftNavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            buildMenuItem(
              text: 'Deals',
              icon: Icons.table_chart,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 30,
            ),
            buildMenuItem(
              text: 'Posts',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 1),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    hoverColor: Colors.grey[350],
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.of(context).pushNamed('/loadingProductList');
      break;
    case 1:
      Navigator.of(context).pushNamed('/loadingPostListings');
      break;
  }
}
