import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/base/base_state.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/notification_handler.dart';
import 'package:lechoix/ui/screens/host/more/notification_bloc.dart';
import 'package:lechoix/ui/widget/button/elevated_button_widget.dart';
import 'package:lechoix/ui/widget/button/text_button_widget.dart';
import 'package:lechoix/ui/widget/image/cached_image_widget.dart';
import 'package:lechoix/ui/widget/onBoarding_widget.dart';
import 'package:lechoix/ui/widget/space_widget.dart';

import '../../../../data/response/OnBoardingResponse.dart';
class OnBoardingNotificationsWidget extends StatefulWidget {
  final Function() callBack;

  const OnBoardingNotificationsWidget({super.key, required this.callBack});

  @override
  _OnBoardingNotificationsWidgetState createState() =>
      _OnBoardingNotificationsWidgetState();
}

class _OnBoardingNotificationsWidgetState
    extends BaseState<OnBoardingNotificationsWidget, NotificationBloc> {
  OnBoardingModel screenContent = UserCache.instance.getOnBoardingScreen(2);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        topWidget: Stack(children: [
          CachedImageWidget(
            imageUrl: screenContent.image ?? "",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Image.asset(
              "assets/images/notification_icon.png",
              width: MediaQuery.of(context).size.width - 40,
            ),
          )
        ]),
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  screenContent.getTitle(),
                  style: TextStyleConstants.titleBold.copyWith(
                    color: UIConstants.gray1Color,
                  ),
                ),
                const VerticalSpace(20),
                Text(
                  screenContent.getContent(),
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.titleRegular.copyWith(
                    color: UIConstants.gray2Color,
                  ),
                ),
                const VerticalSpace(30),
                ElevatedButtonWidget(
                  width: MediaQuery.of(context).size.width / 2 + 50,
                  onClick: requestNotificationPermission,
                  child: Text(screenContent.getActionContent()),
                ),
                TextButtonWidget(
                  onClick: widget.callBack,
                  child: Text(screenContent.getSubTitle()),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> requestNotificationPermission() async {
    await NotificationHandler.instance.init();
    await bloc.updateNotificationToken();

    widget.callBack();
  }

  @override
  void initBloc() {
    bloc = NotificationBloc(this);
  }
}
