import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/card_widget.dart';
import 'package:lechoix/core/widgets/product_widget/shimmer/product_shimmer_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';

import 'package:lechoix/core/widgets/ShimmerWidget.dart';

import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          getBrandShimmerWidget(context),
          getSeparator(context),
          getProductsWidget(context),
          getSeparator(context),
          getBrandShimmerWidget(context),
          getSeparator(context),
          getProductsWidget(context),
        ],
      ),
    );
  }

  getBrandShimmerWidget(BuildContext context) => Column(children: [
        Container(
          height: 200,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(UIConstants.radius),
          ),
        ),
        const VerticalSpace(
          12,
        ),
        CardWidget(
          child: Container(
            height: 4,
            width: 200,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const VerticalSpace(
          4,
        ),
        CardWidget(
          child: Container(
            height: 4,
            width: 150,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const VerticalSpace(
          10,
        ),
        CardWidget(
          child: Container(
            height: 40,
            width: 120,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ]);

  getSeparator(BuildContext context) => Column(children: [
        const VerticalSpace(
          14,
        ),
        CardWidget(
          child: Container(
            height: 2,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const VerticalSpace(
          14,
        ),
      ]);

  getProductsWidget(BuildContext context) => const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ProductShimmerWidget(
              width: 140,
              height: 220,
            ),
            HorizontalSpace(12),
            ProductShimmerWidget(
              width: 140,
              height: 220,
            ),
            HorizontalSpace(12),
            ProductShimmerWidget(
              width: 140,
              height: 220,
            ),
            HorizontalSpace(12),
            ProductShimmerWidget(
              width: 140,
              height: 220,
            ),
          ],
        ),
      );
}
