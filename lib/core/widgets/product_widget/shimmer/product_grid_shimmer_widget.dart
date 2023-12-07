import 'package:flutter/cupertino.dart';
import 'package:lechoix/core/widgets/product_widget/shimmer/product_shimmer_widget.dart';

import '../../ShimmerWidget.dart';

class ProductGridShimmerWidget extends StatelessWidget {
  const ProductGridShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: GridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [1, 2, 3, 4, 5, 6, 7, 8]
            .map(
              (e) => const ProductShimmerWidget(),
            )
            .toList(),
      ),
    );
  }
}
