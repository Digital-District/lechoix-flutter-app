import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final String placeholder;
  final BoxFit fit;
  final int? maxHeightDiskCache;
  final int? maxWidthDiskCache;
  final double? width;
  final double? height;

  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    this.placeholder = "assets/images/logo_black_icon.png",
    this.fit = BoxFit.cover,
    this.maxHeightDiskCache,
    this.maxWidthDiskCache,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      maxHeightDiskCache: maxHeightDiskCache,
      maxWidthDiskCache: maxWidthDiskCache,
      placeholder: (context, url) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.asset(placeholder, scale: 2),
      ),
      errorWidget: (context, url, error) => AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.asset(placeholder, scale: 2),
      ),
    );
  }
}
