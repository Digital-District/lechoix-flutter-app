import 'package:flutter/material.dart';

import '../util/utils/consts/ui_constants.dart';
import 'textField/text_field_widget.dart';

class AppBarWidget extends AppBar {
  final Widget centerWidget;
  final String? subText;
  final Widget? leadingIcon;
  final Widget? actionIcon;
  final Color? color;
  final Color? textColor;
  final bool showDivider;
  final Function(String)? onSubmitSearch;

  AppBarWidget(
      {super.key,
      required this.centerWidget,
      this.subText,
      this.leadingIcon,
      this.actionIcon,
      this.color,
      this.textColor,
      this.showDivider = true,
      this.onSubmitSearch})
      : super(
          title: centerWidget,
          elevation: 0,
          backgroundColor: color,
          foregroundColor: textColor,
          centerTitle: true,
          leading: leadingIcon,
          actions: actionIcon != null ? [actionIcon] : [],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(subText != null ? 40 : 0),
            child: Column(
              children: [
                if (subText != null)
                  Column(
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        subText,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                Visibility(
                  visible: showDivider,
                  child: const Divider(height: 1, thickness: 1),
                ),
              ],
            ),
          ),
        );

  AppBarWidget.logo({
    String logo = "assets/images/logo_black_icon.png",
    String? subText,
    Widget? leadingIcon,
    Widget? actionIcon,
    Color? color,
    Color? textColor,
  }) : this(
          centerWidget: Image.asset(logo, width: 100),
          subText: subText,
          leadingIcon: leadingIcon,
          actionIcon: actionIcon,
          color: color,
          textColor: textColor,
        );

  AppBarWidget.search({
    super.key,
    required this.centerWidget,
    required this.onSubmitSearch,
    this.subText,
    this.leadingIcon,
    this.actionIcon,
    this.color,
    this.textColor,
    this.showDivider = true,
  }) : super(
          title: centerWidget,
          elevation: 0,
          backgroundColor: color,
          foregroundColor: textColor,
          centerTitle: true,
          leading: leadingIcon,
          actions: actionIcon != null ? [actionIcon] : [],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: TextEditingController(),
                    hideBorder: true,
                    hint: "Search for products",
                    onSubmit: onSubmitSearch,
                    fillColor: UIConstants.gray6Color,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        "assets/images/ic_search.png",
                        height: 25,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: showDivider,
                    child: const Divider(height: 1, thickness: 1),
                  ),
                ],
              ),
            ),
          ),
        );
}
