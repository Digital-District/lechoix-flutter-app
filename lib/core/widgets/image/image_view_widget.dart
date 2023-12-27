import 'package:flutter/material.dart';

import '../app_bar_widget.dart';
import 'cached_image_widget.dart';

class ImageViewWidget extends StatelessWidget {
  final String imageUrl;

  const ImageViewWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: const Text(""),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: "heroImage",
          child: CachedImageWidget(
            imageUrl: imageUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
