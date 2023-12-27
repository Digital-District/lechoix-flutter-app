import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../util/utils/consts/text_style_constants.dart';
import '../../util/utils/consts/ui_constants.dart';
import '../space_widget.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final Widget bottomWidget;

  const InputFieldWidget(
      {super.key, required this.label, required this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr(label),
            style: TextStyleConstants.captionBold.copyWith(
              color: UIConstants.gray1Color,
            )),
        const VerticalSpace(8),
        bottomWidget,
        const VerticalSpace(24),
      ],
    );
  }
}
