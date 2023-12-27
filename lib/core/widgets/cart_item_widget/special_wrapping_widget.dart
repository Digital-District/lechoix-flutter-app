import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../util/utils/consts/text_style_constants.dart';
import '../../util/utils/consts/ui_constants.dart';
import '../space_widget.dart';

class SpecialWrappingWidget extends StatelessWidget {
  const SpecialWrappingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                "assets/images/special_wrapping_icon.png",
                width: 25,
                height: 30,
              ),
              const HorizontalSpace(12),
              Expanded(
                child: Text(
                  tr("Special wrapping & packaging included"),
                  style: TextStyleConstants.captionRegular.copyWith(
                    color: UIConstants.gray2Color,
                  ),
                ),
              ),
            ],
          ),
        ),
        const VerticalSpace(24),
      ],
    );
  }
}
