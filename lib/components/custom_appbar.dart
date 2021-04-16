import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:salut_app_flutter/theme.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required this.admin,
    required this.imageUrl,
    required this.title,
    required this.function,
  });

  final bool admin;
  final String imageUrl;
  final String title;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        admin
            ? IconButton(
                onPressed: function,
                icon: Icon(
                  Icons.delete,
                ),
              )
            : SizedBox(),
      ],
      title: Text(
        title,
      ),
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Image.network(
          imageUrl,
          fit: kIsWeb ? BoxFit.cover : BoxFit.fill,
        ),
      ),
      expandedHeight: kIsWeb
          ? imageUrl == '-'
              ? 0
              : 400
          : imageUrl == '-'
              ? 0
              : 200,
      backgroundColor: mainColor,
    );
  }
}
