import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/dimenssions/measures.dart';
import '../constant/dimenssions/screenutil.dart';

class CustomShimmer extends StatelessWidget {
  final Widget child;

  const CustomShimmer({
    super.key,
    this.child = const Shimmers(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.3),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: child,
    );
  }
}

class Shimmers extends StatelessWidget {
  const Shimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: screenHeight / 2.8,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: padding20w),
        // controller: controller,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // final data = list[index];
          return const Row(
            children: [
              // HomeCard(
              //   // tap: () {},
              //   hasOption: false,
              //   currency: "",
              //   id: 0,
              //   imgUrl: "}",
              //   isFavorite: true,
              //   priceAftersale: 0,
              //   price: 0,
              //   productName: "",
              // ),
              // const SizedBox(
              //   width: 15,
              // )
            ],
          );
        },
      ),
    );
  }
}
