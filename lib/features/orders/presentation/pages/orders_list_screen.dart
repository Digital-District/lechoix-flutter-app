import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/text_button_widget.dart';
import 'package:lechoix/core/widgets/dialog/dialog_widget.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/no_result_widget.dart';
import 'package:lechoix/data/orders/OrderModel.dart';
import 'package:lechoix/features/orders/presentation/cubit/orders_bloc.dart';
import '../../../../core/base/base_state.dart';
import '../../../../data/orders/MyOrdersResponse.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';

import 'package:lechoix/core/widgets/ShimmerWidget.dart';

import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends BaseState<OrderListScreen, OrdersBloc> {
  @override
  void initBloc() {
    bloc = OrdersBloc(this);
    bloc.getMyOrders();
  }

//////////// APIS And Logic /////////////////
  _cancelOrder(int orderId) async {
    await bloc.cancelOrder(orderId);
    bloc.getMyOrders();
  }

  void _showCancelDialog(int orderId) {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: localize(localize("Do you want to cancel this order?")),
        cancelMsg: localize("No"),
        confirmMsg: localize("Yes"),
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          _cancelOrder(orderId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("My Orders")),
        showDivider: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: Theme.of(context).disabledColor,
              unselectedLabelStyle: TextStyleConstants.bodyRegular,
              labelColor: UIConstants.goldColor,
              labelStyle: TextStyleConstants.bodyBold,
              indicatorColor: UIConstants.goldColor,
              tabs: [
                Tab(
                  text: localize("Requested"),
                ),
                Tab(
                  text: localize("Cancelled"),
                ),
              ],
            ),
            const Divider(
              height: 1,
            ),
            const VerticalSpace(20),
            Expanded(
              child: StreamWidget<MyOrdersResponse?>(
                  stream: bloc.controller.stream,
                  onRetry: bloc.getMyOrders,
                  loadingWidget: ShimmerWidget(child: getShimmerWidget()),
                  child: (myOrders) {
                    return TabBarView(
                      children: [
                        getListOfWidgets(
                            myOrders?.pendingList ?? [], true, true),
                        getListOfWidgets(
                            myOrders?.cancelledList ?? [], false, false),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
//////////// UI /////////////////

  Widget getListOfWidgets(
      List<OrderModel> dataList, bool showTrackOrder, bool showCancelBtn) {
    return dataList.isNotEmpty
        ? ListView.separated(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = dataList[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UIConstants.gray3Color,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(
                    UIConstants.radius,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            localize("Order"),
                            style: TextStyleConstants.headline5,
                          ),
                          const HorizontalSpace(16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: UIConstants.goldColor,
                              borderRadius: BorderRadius.circular(
                                UIConstants.radius,
                              ),
                            ),
                            child: Text(
                              orderModel.orderNumber ?? "",
                              style: TextStyleConstants.captionRegular
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                          TextButtonWidget(
                            padding: EdgeInsets.zero,
                            onClick: () {
                              _showCancelDialog(orderModel.id ?? 1);
                            },
                            child: Visibility(
                              visible:
                                  showCancelBtn && orderModel.statusId == 1,
                              child: Text(
                                localize("Cancel"),
                                style: TextStyleConstants.bodyRegular
                                    .copyWith(color: UIConstants.gray2Color),
                              ),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                          visible: showTrackOrder,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const VerticalSpace(16),
                              Text(
                                localize("Order tracking"),
                                style: TextStyleConstants.bodyBold,
                              ),
                              const VerticalSpace(10),
                              Row(
                                children: [
                                  getOrderTrackingWidget(
                                    "assets/images/clock.png",
                                    "Preparing",
                                    orderModel.statusId == 1,
                                  ),
                                  const HorizontalSpace(16),
                                  Text(
                                    ">",
                                    style: TextStyleConstants.captionRegular
                                        .copyWith(
                                      color: UIConstants.gray1Color,
                                    ),
                                  ),
                                  const HorizontalSpace(16),
                                  getOrderTrackingWidget(
                                    "assets/images/delivery_truck.png",
                                    "Shipped",
                                    orderModel.statusId == 2,
                                  ),
                                  const HorizontalSpace(16),
                                  Text(
                                    ">",
                                    style: TextStyleConstants.captionRegular
                                        .copyWith(
                                      color: UIConstants.gray1Color,
                                    ),
                                  ),
                                  const HorizontalSpace(16),
                                  getOrderTrackingWidget(
                                    "assets/images/box.png",
                                    "Delivered",
                                    orderModel.statusId == 3,
                                  ),
                                ],
                              )
                            ],
                          )),
                      const VerticalSpace(16),
                      Text(
                        localize("Shipping Address"),
                        style: TextStyleConstants.bodyBold,
                      ),
                      const VerticalSpace(10),
                      Text(
                        localize(orderModel.address?.getDetailAddress() ?? ""),
                        style: TextStyleConstants.captionRegular.copyWith(
                          color: UIConstants.gray3Color,
                        ),
                      ),
                      const VerticalSpace(16),
                      Text(
                        localize("Payment Method"),
                        style: TextStyleConstants.bodyBold,
                      ),
                      const VerticalSpace(10),
                      Text(
                        localize(orderModel.getPaymentDetails()),
                        style: TextStyleConstants.captionRegular.copyWith(
                            color: UIConstants.gray3Color,
                            fontFamily: "Avenir"),
                      ),
                      const VerticalSpace(16),
                      Text(
                        localize("Order Date"),
                        style: TextStyleConstants.bodyBold,
                      ),
                      const VerticalSpace(10),
                      Text(
                        localize(orderModel.createdAt ?? ""),
                        style: TextStyleConstants.captionRegular.copyWith(
                          color: UIConstants.gray3Color,
                        ),
                      ),
                      const VerticalSpace(4),
                      Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.zero,
                          tilePadding: EdgeInsets.zero,
                          title: Text(localize("Order Items"),
                              style: TextStyleConstants.bodyBold
                                  .copyWith(color: UIConstants.blackColor)),
                          iconColor: UIConstants.blackColor,
                          collapsedIconColor: UIConstants.blackColor,
                          children: orderModel.cart!
                              .map(
                                (cartItem) => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CachedImageWidget(
                                      imageUrl: cartItem.image ?? "",
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                    ),
                                    const HorizontalSpace(16),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartItem.name ?? "",
                                            maxLines: 1,
                                            style: TextStyleConstants
                                                .captionRegular
                                                .copyWith(
                                              color: UIConstants.gray1Color,
                                            ),
                                          ),
                                          const VerticalSpace(4),
                                          Text(
                                            "${cartItem.quantity} ${localize("items")}",
                                            style: TextStyleConstants
                                                .captionRegular
                                                .copyWith(
                                              color: UIConstants.gray1Color,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const HorizontalSpace(16),
                                    Text(
                                      "${(cartItem.salePrice == null || cartItem.salePrice == "null") ? cartItem.price : cartItem.salePrice} ${cartItem.currency}",
                                      style: TextStyleConstants.price.copyWith(
                                        color: UIConstants.gray1Color,
                                      ),
                                    )
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Padding(padding: EdgeInsets.all(12)),
          )
        : const NoResultWidget();
  }

  Widget getOrderTrackingWidget(String image, String name, bool isSelected) {
    return Column(
      children: [
        Image.asset(
          image,
          width: 30,
          height: 30,
        ),
        const VerticalSpace(8),
        Text(
          localize(name),
          style: isSelected
              ? TextStyleConstants.captionBold.copyWith(
                  color: UIConstants.blackColor,
                )
              : TextStyleConstants.captionRegular.copyWith(
                  color: UIConstants.gray3Color,
                ),
        )
      ],
    );
  }

  getShimmerWidget() => ListView(
        padding: const EdgeInsets.all(8.0),
        children: [1, 2, 3, 4, 5, 6, 7, 8]
            .map(
              (e) => Container(
                height: 100,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(UIConstants.radius),
                ),
              ),
            )
            .toList(),
      );
}
