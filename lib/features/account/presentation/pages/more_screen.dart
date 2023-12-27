import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/notification_handler.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/dialog/dialog_widget.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/need_help_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/account/presentation/pages/edit_profile_screen.dart';
import 'package:lechoix/features/address/presentation/pages/my_address/address_screen.dart';
import 'package:lechoix/features/auth/presentation/pages/login_screen.dart';
import 'package:lechoix/features/auth/presentation/pages/register_screen.dart';
import 'package:lechoix/features/orders/presentation/pages/orders_list_screen.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/base/dummy_bloc.dart';
import '../../../../core/cache/user_cache.dart';
import '../../../../core/util/utils/consts/text_style_constants.dart';
import '../../../../core/util/utils/consts/ui_constants.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/button/text_button_widget.dart';
import '../../../../core/widgets/more_widget.dart';
import '../../../notifications/presentation/cubit/notification_bloc.dart';
import 'dynamic_HTML/dynamic_HTML_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MoreScreenState();
}

class _MoreScreenState extends BaseState<MoreScreen, DummyBloc> {
  late NotificationBloc notificationBloc;

  @override
  void initBloc() {
    bloc = DummyBloc(this);
    notificationBloc = NotificationBloc(this);
  }

  @override
  void dispose() {
    notificationBloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("More")),
        actionIcon: isLoggedIn
            ? TextButtonWidget(
                padding: EdgeInsets.zero,
                onClick: _showLogoutDialog,
                child: Text(
                  localize("Logout"),
                  style: TextStyleConstants.captionBold.copyWith(
                    color: UIConstants.goldColor,
                  ),
                ),
              )
            : Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoggedIn ? getLoggedInView() : getGuestView(),
            Column(
              children: [
                Visibility(
                  visible: isLoggedIn,
                  child: Column(
                    children: [
                      MoreWidget(
                        title: localize("My Address"),
                        img: "assets/images/ic_address.png",
                        onClick: () {
                          navigateTo(const AddressScreen());
                        },
                      ),
                      MoreWidget(
                        title: localize("My Orders"),
                        img: "assets/images/ic_orders.png",
                        onClick: () {
                          navigateTo(const OrderListScreen());
                        },
                      ),
                    ],
                  ),
                ),
                MoreWidget(
                  title: localize("Terms & Conditions"),
                  onClick: () {
                    // navigateTo(const DynamicHTMLScreen(
                    //     "Terms & Conditions", "terms-and-conditions"));
                  },
                ),
                MoreWidget(
                  title: localize("Returns Policy"),
                  onClick: () {
                    // navigateTo(const DynamicHTMLScreen(
                    //     "Returns Policy", "return-policy"));
                  },
                ),
                MoreWidget(
                  title: localize("Privacy Policy"),
                  onClick: () {
                    // navigateTo(const DynamicHTMLScreen(
                    //     "Privacy Policy", "privacy-policy"));
                  },
                ),
                MoreWidget(
                  title: localize("FAQs"),
                  onClick: () {
                    // navigateTo(const DynamicHTMLScreen("FAQ", "faq"));
                  },
                ),
                MoreWidget(
                  title: localize("Switch language"),
                  onClick: _showChangeLangDialog,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          localize("Allow Receive notifications"),
                          style: TextStyleConstants.titleRegular.copyWith(
                            color: UIConstants.gray1Color,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 25,
                        child: Switch(
                          value: UserCache.instance.getAllowFCMStatus(),
                          activeColor: Theme.of(context).colorScheme.primary,
                          activeTrackColor:
                              Theme.of(context).colorScheme.onPrimary,
                          inactiveThumbColor: UIConstants.gray4Color,
                          onChanged: (value) {
                            // _updateFCMStatus(value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                const NeedHelpWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getLoggedInView() {
    return Column(
      children: [
        Container(
          height: 230,
          color: UIConstants.goldColor.withOpacity(0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 2.0, color: UIConstants.blackColor),
                  ),
                  child: ClipOval(
                    child: CachedImageWidget(
                      imageUrl: currentUser?.avatar ?? "",
                      placeholder: "assets/images/profile_icon.png",
                      fit: BoxFit.cover,
                      maxHeightDiskCache: 80,
                      maxWidthDiskCache: 80,
                    ),
                  ),
                ),
                const VerticalSpace(12),
                Text(
                  "${localize("Hello")}, ${currentUser?.firstName}",
                  style: TextStyleConstants.titleRegular.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const VerticalSpace(16),
                OutlinedButtonWidget(
                  borderColor: UIConstants.blackColor,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  width: MediaQuery.of(context).size.width / 2,
                  onClick: () async {
                    await navigateTo(const EditProfileScreen());
                    setState(() {});
                  },
                  child: Text(localize("Edit profile")),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getGuestView() {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/more_placeholder_icon.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localize(
                  "Login or Register for faster checkout and personalize your experience."),
              textAlign: TextAlign.center,
              style: TextStyleConstants.titleRegular.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const VerticalSpace(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButtonWidget(
                      padding: const EdgeInsets.all(12),
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      onClick: () {
                        navigateTo(const LoginScreen(), fullscreenDialog: true);
                      },
                      child: Text(localize("LOGIN")),
                    ),
                  ),
                  const HorizontalSpace(16),
                  Expanded(
                    child: ElevatedButtonWidget(
                      padding: const EdgeInsets.all(12),
                      color: UIConstants.goldColor,
                      textColor: Theme.of(context).colorScheme.primary,
                      onClick: () {
                        navigateTo(const RegisterScreen(),
                            fullscreenDialog: true);
                      },
                      child: Text(localize("REGISTER")),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showChangeLangDialog() {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: localize("Do you want to change the current language?"),
        cancelMsg: localize("Cancel"),
        confirmMsg: localize("Change"),
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          if (EasyLocalization.of(context)?.locale.languageCode == "ar") {
            EasyLocalization.of(context)?.setLocale(const Locale('en', 'US'));
            UserCache.instance.setLanguage("en");
          } else {
            EasyLocalization.of(context)?.setLocale(const Locale('ar', 'EG'));
            UserCache.instance.setLanguage("ar");
          }
          NavigationUtil.pushReplacementAndClear(
              context, RouteUtil.splashRoute);
        },
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: localize("Do you want to logout?"),
        cancelMsg: localize("Cancel"),
        confirmMsg: localize("Logout"),
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          kickUserOut();
        },
      ),
    );
  }

  void kickUserOut() {
    UserCache.instance.logout();
    NavigationUtil.pushReplacementAndClear(
        NavigationUtil.navigatorKey.currentContext!, RouteUtil.splashRoute);
  }

  Future<void> _updateFCMStatus(bool newStatus) async {
    if (newStatus) {
      await NotificationHandler.instance.init();
      await notificationBloc.updateNotificationToken();
    } else {
      await notificationBloc.deleteNotificationToken();
    }
    setState(() {});
  }
}
