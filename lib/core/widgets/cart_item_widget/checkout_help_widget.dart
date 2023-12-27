import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../util/utils/consts/text_style_constants.dart';
import '../../util/utils/consts/ui_constants.dart';
import '../need_help_widget.dart';
import '../space_widget.dart';

class CheckoutHelpWidget extends StatelessWidget {
  const CheckoutHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                "assets/images/gard_icon.png",
                width: 25,
                height: 30,
              ),
              const HorizontalSpace(12),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: TextStyleConstants.captionRegular.copyWith(
                      color: UIConstants.gray2Color,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            "${tr("Shop worry-free! We offer free and easy returns within 7days.")} ",
                      ),
                      TextSpan(
                        text: "${tr("Learn more")},",
                        style: const TextStyle(decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()

                          ..onTap = () {
                            /// TODO: add html screen
                            // NavigationUtil.navigateTo(context,  DynamicHTMLScreen("Returns Policy", "return-policy"),
                            //     fullscreenDialog: true);


                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpace(24),
        const NeedHelpWidget(),
      ],
    );
  }
}
