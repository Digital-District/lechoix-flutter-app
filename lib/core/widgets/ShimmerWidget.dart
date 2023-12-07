import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;

  const ShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: UIConstants.shimmer,
      highlightColor: Colors.white70,
      child: child,
    );
  }
}
