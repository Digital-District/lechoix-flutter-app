import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/ShimmerWidget.dart';
import 'package:lechoix/core/widgets/address/address_item_widget.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_list_widget.dart';
import 'package:lechoix/features/address/presentation/cubit/address_bloc.dart';
import 'package:lechoix/features/address/presentation/pages/add/add_address_screen.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../data/address/AddressModel.dart';

class AddressScreen extends StatefulWidget {
  final bool isCameFromCart;
  final int currentShippingAddressID;

  const AddressScreen(
      {super.key,
      this.isCameFromCart = false,
      this.currentShippingAddressID = -1});

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends BaseState<AddressScreen, AddressBloc> {
  @override
  void initBloc() {
    bloc = AddressBloc(this);
    bloc.getMyAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("My Address")),
      ),
      body: Stack(
        children: [
          StreamListWidget<AddressModel>(
              stream: bloc.controller.stream,
              onRetry: bloc.getMyAddress,
              noResultWidget: Container(),
              loadingWidget: ShimmerWidget(child: getShimmerWidget()),
              child: (model) {
                return AddressItemWidget(
                  model: model,
                  isCameFromCart: widget.isCameFromCart,
                  currentShippingAddressID: widget.currentShippingAddressID,
                  setDefaultAction: () {
                    _setAddressDefault(model.id ?? 1);
                  },
                  onEditClick: () {
                    _goToAddAddress(model);
                  },
                  onClick: () {
                    if (widget.isCameFromCart) {
                      Navigator.pop(context, model);
                    } else {
                      _goToAddAddress(model);
                    }
                  },
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
              child: ElevatedButtonWidget(
                width: double.infinity,
                child: Text(localize("ADD NEW ADDRESS")),
                onClick: () {
                  _goToAddAddress(null);
                },
              ),
            ),
          )
        ],
      ),
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

  _setAddressDefault(int addressId) async {
    var res = await bloc.setDefault(addressId);
    if (res) {
      bloc.getMyAddress();
    }
  }

  _goToAddAddress(AddressModel? model) async {
    final res = await navigateTo(AddAddressScreen(
      oldAddressModel: model,
      isCameFromCart: widget.isCameFromCart,
    ));
    if (res != null) {
      bloc.getMyAddress();
    }
  }
}
