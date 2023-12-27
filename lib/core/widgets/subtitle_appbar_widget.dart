import 'package:flutter/material.dart';
import 'space_widget.dart';

class SubtitleAppBarWidget extends PreferredSize {
  final double height;
  final Widget title;
  final Widget? subtitle;
  final Widget? leadingIcon;
  final Widget? actionIcon;
  final bool showDivider;

  SubtitleAppBarWidget({
    super.key,
    this.height = 76.0,
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.actionIcon,
    this.showDivider = false,
  }) : super(
          preferredSize: Size.fromHeight(height),
          child: AppBar(
            elevation: 0.0,
            leading: leadingIcon,
            actions: actionIcon != null ? [actionIcon] : [],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child:
                  showDivider ? const Divider(height: 1, thickness: 1) : Container(),
            ),
            flexibleSpace: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    title,
                    if (subtitle != null) const VerticalSpace(8.0),
                    if (subtitle != null) subtitle,
                  ],
                ),
              ),
            ),
          ),
        );
}
