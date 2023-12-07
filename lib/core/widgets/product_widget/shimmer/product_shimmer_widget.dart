import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/space_widget.dart';

import '../../card_widget.dart';

class ProductShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ProductShimmerWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CardWidget(
              child: Container(),
            ),
          ),
                const VerticalSpace(
            12,
          ),
          CardWidget(
            child: Container(
              height: 8,
              width: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const VerticalSpace(
            10,
          ),
          CardWidget(
            child: Container(
              height: 8,
              width: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const VerticalSpace(
            10,
          ),
          CardWidget(
            child: Container(
              height: 8,
              width: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
