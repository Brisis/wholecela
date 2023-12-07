import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';

class AvatarImage extends StatelessWidget {
  final String? imageUrl;
  final bool? isSeller;
  const AvatarImage({
    super.key,
    this.imageUrl,
    this.isSeller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: imageUrl != null
            ? DecorationImage(
                image:
                    NetworkImage("${AppUrls.SERVER_URL}/thumbnails/$imageUrl"),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: AssetImage(isSeller != null
                    ? "assets/images/shop.png"
                    : "assets/images/user.jpg"),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
