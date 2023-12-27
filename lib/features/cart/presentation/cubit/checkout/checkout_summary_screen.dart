import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/cart_fees_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/cart_item_widget.dart';
import 'package:lechoix/core/widgets/loading_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/cart/presentation/pages/cart_screen.dart';
import '../../../../../core/base/dummy_bloc.dart';
import '../../../../../data/cart/CartModel.dart';
import '../../../../../data/cart/CartSummaryModel.dart';
import '../../../../../data/orders/OrderModel.dart';

import '../../../../../core/base/base_state.dart';

class CheckoutSummaryScreen extends StatefulWidget {
  final OrderModel checkoutResponse;

  const CheckoutSummaryScreen({super.key, required this.checkoutResponse});

  @override
  State<CheckoutSummaryScreen> createState() => _CheckoutSummaryScreenState();
}

class _CheckoutSummaryScreenState
    extends BaseState<CheckoutSummaryScreen, DummyBloc> {
  bool isLoading = true;
  List<CartModel> dataList = [];

  @override
  void initBloc() {
    bloc = DummyBloc(this);
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          : SingleChildScrollView(
              child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/checkout_icon.png"),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_white_icon.png",
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      const VerticalSpace(16),
                      Text(
                        localize("THANK YOU!"),
                        style: TextStyleConstants.headline5.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                      const VerticalSpace(8),
                      Text(
                        localize("❤ For shopping with us ❤"),
                        style: TextStyleConstants.titleRegular.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: UIConstants.goldColor.withOpacity(0.1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localize(
                                      "An email confirmation has been sent to"),
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray1Color),
                                ),
                                Text(
                                  "${widget.checkoutResponse.address?.email}",
                                  style: TextStyleConstants.bodyBold
                                      .copyWith(color: UIConstants.gray1Color),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Image.asset(
                              "assets/images/envelope_icon.png",
                              width: 30,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: UIConstants.gray5Color,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  localize("Your order ID"),
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray1Color),
                                ),
                                const Spacer(),
                                Text(
                                  "${widget.checkoutResponse.orderNumber}",
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray2Color),
                                ),
                              ],
                            ),
                            const VerticalSpace(8),
                            Row(
                              children: [
                                Text(
                                  localize("Estimated Delivery"),
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray1Color),
                                ),
                                const Spacer(),
                                Text(
                                  "${widget.checkoutResponse.estimatedDelivery} ${localize("working days")}",
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray2Color),
                                ),
                              ],
                            ),
                            const VerticalSpace(8),
                            Row(
                              children: [
                                Text(
                                  localize("Delivery address"),
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray1Color),
                                ),
                                const Spacer(),
                                Text(
                                  "${widget.checkoutResponse.address?.getName()}",
                                  maxLines: 3,
                                  textAlign: TextAlign.end,
                                  style: TextStyleConstants.bodyRegular
                                      .copyWith(color: UIConstants.gray2Color),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                getCartListWidget(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    children: [
                      CartFeesWidget(
                        cartSummary: widget.checkoutResponse.cartSummary ??
                            CartSummaryModel(),
                        currency:
                            widget.checkoutResponse.cart?[0].currency ?? "",
                        showDeliveryFees: true,
                      ),
                      const VerticalSpace(24),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(UIConstants.radius),
                          color: UIConstants.goldColor.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            localize(
                                "Please note: after three unsuccessful attempts to deliver your order, it will be cancelled and you will be notified accordingly."),
                            style: TextStyleConstants.bodyRegular.copyWith(
                              color: UIConstants.gray2Color,
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpace(24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButtonWidget(
                          onClick: _continueShopping,
                          child: Text(localize("CONTINUE SHOPPING")),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
    );
  }

  Widget getCartListWidget() {
    return Column(
      children: widget.checkoutResponse.cart!.map(
        (model) {
          return CartItemWidget(
            cartModel: model,
            isMyCart: false,
          );
        },
      ).toList(),
    );
  }

  void getCart() async {
    isLoading = false;
    dataList = widget.checkoutResponse.cart ?? [];
    setState(() {});
  }

  _continueShopping() {
    pushReplacementAndClear(RouteUtil.hostRoute);
    CartScreen.cartStateKey.currentState?.refresh();
  }
}
