import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/cart_fees_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/checkout_help_widget.dart';
import 'package:lechoix/core/widgets/cart_item_widget/special_wrapping_widget.dart';
import 'package:lechoix/core/widgets/loading_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/account/presentation/pages/dynamic_HTML/dynamic_HTML_screen.dart';
import 'package:lechoix/features/address/presentation/pages/my_address/address_screen.dart';
import 'package:lechoix/features/cart/presentation/cubit/cart/cart_bloc.dart';
import 'package:lechoix/features/cart/presentation/cubit/checkout/checkout_summary_screen.dart';
import 'package:lechoix/features/cart/presentation/pages/cart_screen.dart';
import 'package:lechoix/features/orders/presentation/cubit/orders_bloc.dart';
import 'package:lechoix/main.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../core/cache/configuration_cache.dart';
import '../../../../../core/cache/user_cache.dart';
import '../../../../../data/Enumeration.dart';
import '../../../../../data/address/AddressModel.dart';
import '../../../../../data/cart/CartResponse.dart';
import '../../../../../data/cart/CartSummaryModel.dart';
import '../../../../../data/orders/OrderModel.dart';

class CheckoutStep2Screen extends StatefulWidget {
  const CheckoutStep2Screen({super.key});

  @override
  State<CheckoutStep2Screen> createState() => _CheckoutStep2ScreenState();
}

class _CheckoutStep2ScreenState
    extends BaseState<CheckoutStep2Screen, CartBloc> {
  late OrdersBloc ordersBloc;

  bool isLoading = true;
  CartResponse? cartResponse;
  AddressModel? addressModel;
  int? addressId;

  PaymentMethod selectedPaymentMethod = PaymentMethod.non;
  String? discountCode;

  @override
  void initBloc() {
    bloc = CartBloc(this);
    ordersBloc = OrdersBloc(this);
    discountCode = UserCache.instance.getCoupon();
    getShippingAddress();
    _initPaymentSKD();
  }

  @override
  void dispose() {
    ordersBloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("Order Confirmation")),
      ),
      body: isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  getAddressWidget(),
                  const Divider(height: 1),
                  getPaymentsOptionsWidget(),
                  getCartSummaryWidget(),
                  const SpecialWrappingWidget(),
                  const CheckoutHelpWidget(),
                ],
              ),
            ),
    );
  }

//////////// UI Widget /////////////////

  Widget getAddressWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            localize("Shipping Address"),
            style: TextStyleConstants.titleBold,
          ),
        ),
        addressModel == null
            ? SizedBox(
                height: 80,
                child: Center(
                  child: OutlinedButtonWidget(
                    width: MediaQuery.of(context).size.width - 80,
                    borderColor: UIConstants.blackColor,
                    onClick: _pickShippingAddress,
                    child: Text(localize("PICK SHIPPING ADDRESS")),
                  ),
                ),
              )
            : GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _pickShippingAddress,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              addressModel?.getName() ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleConstants.bodyBold,
                            ),
                            const VerticalSpace(10),
                            Text(
                              addressModel?.phone ?? "",
                              style: TextStyleConstants.bodyRegular,
                            ),
                            const VerticalSpace(10),
                            Text(
                              addressModel?.getFullAddress() ?? "",
                              style: TextStyleConstants.bodyRegular,
                            ),
                            const VerticalSpace(6),
                            Text(
                              addressModel?.getLocation() ?? "",
                              style: TextStyleConstants.bodyRegular,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/images/arrow_icon.png",
                        matchTextDirection: true,
                        width: 16,
                        height: 16,
                      )
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Widget getPaymentsOptionsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            localize("Payment Method"),
            style: TextStyleConstants.titleBold,
          ),
        ),
        Visibility(
          visible: ConfigurationCache.instance.getData?.onlinePayment ?? false,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                getPaymentItemWidget(
                  PaymentMethod.onlinePayment,
                  "",
                ),
                Visibility(
                    visible:
                        PaymentMethod.onlinePayment == selectedPaymentMethod,
                    child: Container(
                      height: 300,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: _customPaymentCardView(),
                      ),
                    ))
              ],
            ),
          ),
        ),
        Visibility(
          visible: ConfigurationCache.instance.getData?.cashOnDelivery ?? false,
          child: getPaymentItemWidget(
            PaymentMethod.cashOnDelivery,
            ConfigurationCache.instance.getData?.getCashOnDeliveryFees() ?? "",
          ),
        ),
        Visibility(
          visible: ConfigurationCache.instance.getData?.cardOnDelivery ?? false,
          child: getPaymentItemWidget(
            PaymentMethod.cardOnDelivery,
            "",
          ),
        ),
      ],
    );
  }

  Widget getPaymentItemWidget(PaymentMethod method, String additionalFees) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              if (selectedPaymentMethod != method) {
                selectedPaymentMethod = method;
                if (selectedPaymentMethod == PaymentMethod.onlinePayment) {
                  _initPaymentSKDSession();
                  // setState(() {
                  //   isLoading = true ;
                  // });
                  // Future.delayed(Duration(milliseconds: 100));
                }
                showProgress();
                getCart();
              }
            },
            child: Row(
              children: [
                Image.asset(
                  selectedPaymentMethod == method
                      ? "assets/images/radio_buttons_icon.png"
                      : "assets/images/empty_radio_buttons_icon.png",
                  width: 20,
                  height: 20,
                ),
                const HorizontalSpace(8),
                Expanded(
                  child: Text(
                    localize(method.getName(method.getValue(method) ?? 1)),
                    style: TextStyleConstants.bodyRegular,
                  ),
                ),
                Visibility(
                  visible: additionalFees.isNotEmpty,
                  child: Text(
                    additionalFees,
                    style: TextStyleConstants.price.copyWith(
                      color: UIConstants.goldColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget getCartSummaryWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CartFeesWidget(
            cartSummary: cartResponse?.cartSummary ?? CartSummaryModel(),
            currency: cartResponse?.cart?[0].currency ?? "",
            showDeliveryFees: true,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButtonWidget(
              onClick: _placeOrder,
              child: Text(localize("PLACE ORDER")),
            ),
          ),
          const VerticalSpace(10),
          Text.rich(
            TextSpan(
              style: TextStyleConstants.captionRegular.copyWith(
                color: UIConstants.gray2Color,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "${tr("By clicking Place Order, you are agreeing to the")} ",
                ),
                TextSpan(
                  text: "${tr("Terms & Conditions")},",
                  style: const TextStyle(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      navigateTo(
                          const DynamicHTMLScreen(
                            "Terms & Conditions",
                            "terms-and-conditions",
                          ),
                          fullscreenDialog: true);
                    },
                ),
              ],
            ),
          ),
          const VerticalSpace(24),
          const Divider(
            height: 1,
          )
        ],
      ),
    );
  }

//////////// APIS And Logic /////////////////

  // Get Address Date
  void getShippingAddress() async {
    addressModel = await bloc.getShippingAddress();
    addressId = addressModel?.id;
    getCart();
  }

  // Get Cart Data
  void getCart() async {
    var response = await bloc.getCart(
        addressId: addressId,
        paymentMethod: selectedPaymentMethod.getValue(selectedPaymentMethod),
        discountCode: discountCode);
    hideProgress();
    if (response?.cart == null || (response?.cart?.isEmpty ?? true)) {
      pushReplacementAndClear(RouteUtil.hostRoute);
      CartScreen.cartStateKey.currentState?.refresh();
      return;
    }
    isLoading = false;
    cartResponse = response;

    setState(() {});
  }

  // Navigate to address screen and pick the address
  _pickShippingAddress() async {
    final result = await navigateTo(
      AddressScreen(
          isCameFromCart: true,
          currentShippingAddressID: addressModel?.id ?? -1),
    );
    if (result != null) {
      AddressModel newSelectedAddress = result;
      isLoading = true;
      addressModel = newSelectedAddress;
      addressId = addressModel?.id;
      setState(() {});
      getCart();
    }
  }

  // Make order Api
  _placeOrder() {
    if (addressModel != null) {
      if (selectedPaymentMethod != PaymentMethod.non) {
        if (selectedPaymentMethod == PaymentMethod.onlinePayment) {
          _payOnline();
        } else {
          _placeOrderAPI();
        }
      } else {
        showErrorMsg(localize("Choose the payment method"));
      }
    } else {
      showErrorMsg(localize("Choose the shipping address"));
    }
  }

  _placeOrderAPI() async {
    OrderModel? response = await ordersBloc.makeOrder(
        addressId ?? 0,
        selectedPaymentMethod.getValue(selectedPaymentMethod),
        discountCode ?? "",
        paymentId,
        invoiceId);
    if (response != null && response.id != null) {
      UserCache.instance.removeCoupon();
      geToCheckoutSummaryScreen(response);
    }
  }

  void geToCheckoutSummaryScreen(OrderModel response) async {
    await navigateTo(CheckoutSummaryScreen(
      checkoutResponse: response,
    ));
    pushReplacementAndClear(RouteUtil.hostRoute);
    CartScreen.cartStateKey.currentState?.refresh();
  }

  /////////////////////////////////////////////////
  // PAYMENT
  MFCountry country = MFCountry.QATAR;

  // Payment View
  late MFPaymentCardView mfPaymentCardView;

  // MFEnvironment environmentLive = MFEnvironment.LIVE;
  // MFEnvironment environmentTEST = MFEnvironment.TEST;
  final String APIKeyTest =
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
  final String APIKeyLive =
      "EUKWzzwj25OCbT6lU7fXRV_wwvx5XV65SBCMg2NG4KC-g0msh6j97p5eUtUGDjT_xDnKmIr0UIqSAO3nM8nvPDXuMPYWQWN6UC6PDMttcIDXZUTvWpvKuCiptVhmcSQbPW4mFc8VNI2UPPAgqEprslkqfP_KCXYZOHxGj2_55TA6LlIjDNFgUtTdCtD3LnM112y6b7TK8yE0eZxMlZeHoqi1hpLZERp5zrT-E98a3_0PX_t6LY2uX5cqTULlnRyFKc3SHYfTabIb_CVNqOg1bcLYAiTVreV4niro9ZOhEPAUKnDWz7giIEORCSyG3eme-IQQOyKv33E6mBajZj7wodaqmdL_MufsAy35VRsbN7luRoUdreLSV32S-Punwo6oZnkjWCniCQ1pJvZNzGgoiqQthYZNyYFsFypvgEGEPHK3zZL0JhZFTlTw9lVLPSyTr2htYIyYcvJpg6POhD4IBq69NkxY1VfB16BEZ8sn9VxkwWLsrOzszoba3k8SCnr5Rrm6sK_IZRk5Z2y9scW4S6qmCX4cp12zITzyD_9qd2GiCalabhZpV0olLCmlvoeQIW-Nf6-yp0J9_w6nCAraF0oB0EgK2HMEzzNwtvCEG17m8QCX0SGT_LTIAUP05duZCF3z3L_RLTcf2F2U3Ljoujr3bN4HAyKzcwwLTiutvkMdWvv5KFq_toq9_e7QxGbGcELIng";

  String invoiceId = "";

  String paymentId = "";

  MFInitiateSessionResponse? initSessionResponse;

  MFEnvironment getPaymentEnvironment() {
    if (isProductionMood) {
      return MFEnvironment.LIVE;
    }
    return MFEnvironment.TEST;
  }

  String getAPIKey() {
    if (isProductionMood) {
      return APIKeyLive;
    }
    return APIKeyTest;
  }

  _initPaymentSKD() {
    MFSDK.init(getAPIKey(), country, getPaymentEnvironment());
  }

  _initPaymentSKDSession() {
    MFSDK.initiateSession(
      null,
      (MFResult<MFInitiateSessionResponse> result) {
        if (result.isSuccess()) {
          initSessionResponse = result.response;
          mfPaymentCardView.load(initSessionResponse!);
        } else {
          showErrorMsg("initPaymentSKDSession Error");
        }
      },
    );
  }

  _customPaymentCardView() {
    mfPaymentCardView = MFPaymentCardView(
      fontSize: 16,
      borderRadius: 4,
      cardHolderNameHint: "First & Last Name",
      cardNumberHint: "1234 0000 1234 0000",
      cvvHint: "CVV/CVC",
      showLabels: true,
      cardHolderNameLabel: "Name on Card",
      cardNumberLabel: "Card Number",
      expiryDateLabel: "Expiration Date",
      cvvLabel: "Security Code",
    );
    mfPaymentCardView.fieldHeight = 40;
    return mfPaymentCardView;
  }

  _payOnline() {
    double totalPayment =
        double.tryParse(cartResponse?.cartSummary?.total ?? "0.0") ?? 0.0;
    if (totalPayment == 0) {
      showErrorMsg("Total Payment Is Invalid");
    } else {
      var request = MFExecutePaymentRequest.constructor(totalPayment);
      mfPaymentCardView.pay(
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) {
          if (result.isSuccess()) {
            List<InvoiceTransactions>? invoiceTransactions =
                result.response?.invoiceTransactions;
            if (invoiceTransactions!.isNotEmpty) {
              paymentId = invoiceTransactions[0].paymentId ?? "";
            }
            this.invoiceId = invoiceId;
            log("SAM Response: ${result.response!.toJson()}");
            _placeOrderAPI();
            // showSuccessMsg("paymentId -> ${paymentId} invoiceId-> ${invoiceId}");
          } else {
            if (result.error?.code != 108) {
              _initPaymentSKDSession();
            }
            String errorMessage = result.error?.message ?? "";
            showErrorMsg(errorMessage);
          }
        },
      );
    }
  }
}
// "First & Last Name": "الاسم الأول و الأخير",
// "Name on Card": "الاسم على البطاقة",
// "Card Number": "رقم البطاقة",
// "Expiration Date": "تاريخ إنتهاء الصلاحية",
// "Security Code": "رمز الحماية"
