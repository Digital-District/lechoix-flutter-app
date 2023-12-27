import 'package:flutter/material.dart';

import '../ShimmerWidget.dart';
import '../card_widget.dart';
import '../space_widget.dart';

class CartShimmerWidget extends StatelessWidget {
  const CartShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => const CartItemShimmerWidget(),
            )
            .toList(),
      ),
    );
  }
}

class CartItemShimmerWidget extends StatelessWidget {
  const CartItemShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardWidget(
              child: Container(
                height: MediaQuery.of(context).size.width / 2.5,
                width: MediaQuery.of(context).size.width / 4,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const HorizontalSpace(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(24),
                CardWidget(
                  child: Container(
                    height: 8,
                    width: 120,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const VerticalSpace(8),
                CardWidget(
                  child: Container(
                    height: 8,
                    width: 100,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const VerticalSpace(8),
                CardWidget(
                  child: Container(
                    height: 8,
                    width: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            )
          ],
        ),
        const VerticalSpace(24)
      ],
    );
  }
}
