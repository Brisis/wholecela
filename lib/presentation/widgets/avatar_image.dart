import 'package:flutter/material.dart';
import 'package:wholecela/core/config/constants.dart';

class AvatarImage extends StatelessWidget {
  final String? imageUrl;
  final bool? isSeller;
  final double? size;
  const AvatarImage({
    super.key,
    this.imageUrl,
    this.isSeller = false,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size! / 2),
        image: imageUrl != null
            ? DecorationImage(
                image:
                    NetworkImage("${AppUrls.SERVER_URL}/thumbnails/$imageUrl"),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: AssetImage(isSeller!
                    ? "assets/images/shop.png"
                    : "assets/images/user.jpg"),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
