import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'button/elevated_button_widget.dart';
import 'space_widget.dart';

class NoResultCartWidget extends StatelessWidget {
  const NoResultCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/bag_icon.png", scale: 2),
          VerticalSpace(40),
          Text(
            tr("Your bag is empty"),
            textAlign: TextAlign.center,
            style: TextStyleConstants.titleBold.copyWith(
              color: UIConstants.gray1Color,
            ),
          ),
          VerticalSpace(20),
          Text(
            tr("Items added to your bag will appear here"),
            textAlign: TextAlign.center,
            style: TextStyleConstants.titleRegular.copyWith(
              color: UIConstants.gray1Color,
            ),
          ),
          VerticalSpace(30),
          ElevatedButtonWidget(
            width: MediaQuery.of(context).size.width / 2,
            child: Text(tr("SHOP NOW")),
            onClick: _shopNow,
          )
        ],
      ),
    );
  }

  _shopNow() {///TODO: remove here
    // HostScreen.hostPageKey.currentState?.navigateToHome();
  }
}
