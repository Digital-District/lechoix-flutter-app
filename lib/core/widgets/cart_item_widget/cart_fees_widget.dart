import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/data/cart/CartSummaryModel.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

import '../space_widget.dart';

class CartFeesWidget extends StatelessWidget {
  final CartSummaryModel cartSummary;
  final bool showDeliveryFees;

  final String currency;

  const CartFeesWidget(
      {super.key,
      required this.cartSummary,
      required this.currency,
      required this.showDeliveryFees});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(16),
        Row(
          children: [
            Text(
              tr("Subtotal"),
              style: TextStyleConstants.bodyRegular.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
            const Spacer(),
            Text(
              "${cartSummary.subTotal} $currency",
              style: TextStyleConstants.price.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
          ],
        ),
        const VerticalSpace(8),
        Row(
          children: [
            Text(
              tr("Tax"),
              style: TextStyleConstants.bodyRegular.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
            const Spacer(),
            Text(
              "${cartSummary.tax?.value}  $currency",
              style: TextStyleConstants.price.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
          ],
        ),

        Visibility(
          visible: showDeliveryFees,
          child: Column(
            children: [
              const VerticalSpace(8),
              Row(
                children: [
                  Text(
                    tr("Delivery Fees"),
                    style: TextStyleConstants.bodyRegular.copyWith(
                      color: UIConstants.gray1Color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    cartSummary.getDeliveryFees(currency),
                    style: TextStyleConstants.price.copyWith(
                      color: UIConstants.gray1Color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Visibility(
        //   visible: cartSummary.hasDiscount(),
        //   child: Column(
        //     children: [
        //       VerticalSpace(8),
        //       Row(
        //         children: [
        //           Text(
        //             tr("Discount"),
        //             style: TextStyleConstants.bodyRegular.copyWith(
        //               color: UIConstants.gray1Color,
        //             ),
        //           ),
        //           Spacer(),
        //           Text(
        //             "- 124 ${currency}",
        //             style: TextStyleConstants.bodyRegular.copyWith(
        //               color: UIConstants.redColor,
        //             ),
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
        Visibility(
          visible: cartSummary.hasCoupon(),
          child: Column(
            children: [
              const VerticalSpace(8),
              Row(
                children: [
                  Text(
                    "${tr("Coupon")}  ${cartSummary.getCouponCode()}",
                    style: TextStyleConstants.bodyRegular.copyWith(
                      color: UIConstants.gray1Color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "- ${cartSummary.discountAmount} $currency",
                    style: TextStyleConstants.price.copyWith(
                      color: UIConstants.redColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const VerticalSpace(8),
        Row(
          children: [
            Text(
              tr("Total"),
              style: TextStyleConstants.bodyBold.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
            const Spacer(),
            Text(
              "${cartSummary.total}  $currency",
              style: TextStyleConstants.price.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
          ],
        ),
        const VerticalSpace(16),
      ],
    );
  }
}
