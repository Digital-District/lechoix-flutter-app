import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/widgets/ShimmerWidget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/cart_fees_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/cart_item_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/cart_shimmer_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/checkout_help_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/special_wrapping_widget.dart';
import 'package:lechoix/core/widgets/no_result_cart_widget.dart';
import 'package:lechoix/core/widgets/subtitle_appbar_widget.dart';
import 'package:lechoix/core/widgets/textField/text_field_widget.dart';
import 'package:lechoix/features/auth/presentation/pages/login_screen.dart';
import 'package:lechoix/features/cart/presentation/cubit/cart/cart_bloc.dart';
import 'package:lechoix/features/cart/presentation/cubit/checkout/checkout_step_2_screen.dart';
import 'package:lechoix/features/product/presentation/pages/product_screen.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/cache/user_cache.dart';
import '../../../../data/cart/CartModel.dart';
import '../../../../data/cart/CartResponse.dart';
import '../../../../data/cart/CartSummaryModel.dart';

class CartScreen extends StatefulWidget {
  static GlobalKey<_CartScreenState> cartStateKey = GlobalKey();

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen, CartBloc> {
  int cartCount = -1;
  bool isLoading = true;
  CartResponse? cartResponse;
  List<CartModel> dataList = [];

  var couponStatus = false;
  String? couponErrorText;
  final TextEditingController _couponController = TextEditingController();

  @override
  void initBloc() {
    bloc = CartBloc(this);
    if (UserCache.instance.getCoupon() != null) {
      couponStatus = true;
      _couponController.text = UserCache.instance.getCoupon() ?? "";
    }
    getCart();
  }

  void refresh() {
    if (couponStatus == false) {
      _couponController.text = "";
      couponErrorText = null;
    }
    cartCount = -1;
    isLoading = true;
    setState(() {});
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubtitleAppBarWidget(
        title: Text(
          localize("Shopping Bag"),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: UIConstants.secondaryColor),
        ),
        subtitle: Text(
          getSubTextValue(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        showDivider: true,
      ),
      body: isLoading
          ? const ShimmerWidget(
              child: CartShimmerWidget(),
            )
          : Container(
              child: cartCount == 0
                  ? const Center(
                      child: NoResultCartWidget(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          getCartListWidget(),
                          getCartSummaryWidget(),
                          const SpecialWrappingWidget(),
                          const CheckoutHelpWidget()
                        ],
                      ),
                    ),
            ),
    );
  }

  Widget getCartListWidget() {
    return Column(
      children: cartResponse!.cart!.map(
        (model) {
          return CartItemWidget(
            cartModel: model,
            onDelete: () {
              getCart();
            },
            onClick: () {
              navigateTo(
                ProductScreen(productId: model.productId ?? 0),
                myContext: NavigationUtil.bagNavigatorKey.currentContext,
              );
            },
            onUpdate: (isAdd) {
              int quantity = model.quantity ?? 0;
              if (isAdd) {
                quantity += 1;
              } else {
                quantity -= 1;
              }
              updateCartItemQuantity(quantity, model);
            },
          );
        },
      ).toList(),
    );
  }

  Widget getCartSummaryWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          TextFieldWidget(
            controller: _couponController,
            errorText: couponErrorText,
            hint: "Enter coupon code here",
            isSuccess: couponStatus,
            onSubmit: (code) {
              chekDiscountCoupon(code);
            },
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButtonWidget(
                child: Text(localize("APPLY")),
                onClick: () {
                  chekDiscountCoupon(_couponController.text);
                },
              ),
            ),
          ),
          CartFeesWidget(
            cartSummary: cartResponse?.cartSummary ?? CartSummaryModel(),
            currency: cartResponse?.cart?[0].currency ?? "",
            showDeliveryFees: false,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButtonWidget(
              onClick: _checkout,
              child: Text(localize("SECURE CHECKOUT")),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateCartItemQuantity(int quantity, CartModel model) async {
    if (quantity > 0) {
      var response = await bloc.updateCartItemQuantity(
          model.id ?? 0, quantity, UserCache.instance.getCoupon());
      cartResponse = response;
      cartCount = cartResponse?.productsCount ?? 0;
      dataList = cartResponse?.cart ?? [];
      setState(() {});
    }
  }

  void getCart() async {
    var response =
        await bloc.getCart(discountCode: UserCache.instance.getCoupon());
    isLoading = false;
    cartResponse = response;
    cartCount = cartResponse?.productsCount ?? 0;
    dataList = cartResponse?.cart ?? [];
    setState(() {});
  }

  _checkout() {
    if (UserCache.instance.isLoggedIn()) {
      navigateTo(const CheckoutStep2Screen());
    } else {
      navigateTo(const LoginScreen(), fullscreenDialog: true);
    }
  }

  String getSubTextValue() {
    if (cartCount == -1) {
      return localize("loading...");
    } else if (cartCount == 0) {
      return "";
    }
    return "$cartCount ${localize("items")}";
  }

  void chekDiscountCoupon(String code) async {
    bool result = await bloc.checkDiscount(code);
    if (result) {
      couponErrorText = null;
      couponStatus = true;
      UserCache.instance.setCoupon(code);
      getCart();
    } else {
      couponErrorText = bloc.couponErrorMes;
      UserCache.instance.removeCoupon();
      setState(() {});
    }
  }
}
