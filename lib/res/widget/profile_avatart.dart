import 'package:bloc_pattern_demo/res/widget/indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ============================= Use For Show Rounded Image  ============================= //

class ProfileAvatar extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;
  ProfileAvatar({
    required this.image,
    this.width,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(500.0),
        child: CachedNetworkImage(
          imageUrl: this.image!,
          width: width ?? 50.0,
          height: height ?? 50.0,
          fit: BoxFit.fill,
          placeholder: (context, url) => Center(
            child: Indicators().indicatorWidget(),
          ),
          errorWidget: (context, url, error) => Container(
            child: Image.asset('graphics/avatar/1.png'),
          ),
        ),
      ),
    );
  }
}
