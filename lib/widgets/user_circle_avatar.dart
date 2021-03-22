import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/app_configs/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
///
/// Created by Sunil Kumar from Boiler plate
///
class UserCircleAvatar extends StatelessWidget {
  final String? userId;
  final String? name;
  final String? imageUrl;
  final double? radius;
  const UserCircleAvatar(this.imageUrl, {this.userId, this.name, this.radius});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Hero(
      tag: userId ?? UniqueKey().toString(),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        imageBuilder: (context, provider) => CircleAvatar(
          backgroundImage: provider,
          radius: radius ?? 32,
        ),
        errorWidget: (c, s, d) => AvatarPlaceholder(
          name ?? ' ',
          backgroundColor: Color(0xffF3F3F3),
          radius: radius ?? 32,
          textColor: Colors.black,
        ),
        placeholder: (context, url) => AvatarPlaceholder(
          name ?? ' ',
          backgroundColor: Color(0xffF3F3F3),
          radius: radius ?? 32,
          textColor: Colors.black,
        ),
      ),
    );
  }
}

class AvatarPlaceholder extends StatelessWidget {
  final String? firstLetter;
  final double? radius;
  final Color? backgroundColor, textColor;
  AvatarPlaceholder(this.firstLetter,
      {this.radius, this.backgroundColor, this.textColor})
      : assert(firstLetter != null, firstLetter?.isNotEmpty);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: SvgPicture.asset(AppAssets.userProfile, fit: BoxFit.cover),
      radius: radius,
      backgroundColor: Colors.grey[300],
    );
  }
}
