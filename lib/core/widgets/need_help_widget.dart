import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cache/configuration_cache.dart';
import '../util/utils/consts/text_style_constants.dart';
import '../util/utils/consts/ui_constants.dart';
import 'button/extended_label_with_icon_widget.dart';
import 'button/outlined_button_widget.dart';
import 'space_widget.dart';

class NeedHelpWidget extends StatelessWidget {
  const NeedHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIConstants.gray7Color,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.rich(
            TextSpan(
              style: TextStyleConstants.bodyRegular.copyWith(
                color: UIConstants.gray2Color,
              ),
              children: [
                TextSpan(text: "${tr("Need help?")} "),
                TextSpan(
                  text: tr("Contact us by"),
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const VerticalSpace(8.0),
          Row(
            children: [
              Expanded(
                child: OutlinedButtonWidget(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  fontSize: 12,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: ExtendedLabelWithIconWidget(
                    icon: Image.asset(
                      "assets/images/ic_phone.png",
                      width: 16,
                      height: 16,
                    ),
                    label:
                        "${tr("Phone")} (${ConfigurationCache.instance.getData?.callStartTime} - ${ConfigurationCache.instance.getData?.callEndTime})",
                  ),
                  onClick: () {
                    launch(
                        "tel://${ConfigurationCache.instance.getData?.phone}");
                  },
                ),
              ),
              const HorizontalSpace(16.0),
              Expanded(
                child: OutlinedButtonWidget(
                  padding: const EdgeInsets.all(10.0),
                  fontSize: 12,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: ExtendedLabelWithIconWidget(
                    icon: Image.asset(
                      "assets/images/ic_email.png",
                      width: 16,
                      height: 16,
                    ),
                    label: tr("Email Inquiry"),
                  ),
                  onClick: () {
                    launch(
                        "mailto:${ConfigurationCache.instance.getData?.email}");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
