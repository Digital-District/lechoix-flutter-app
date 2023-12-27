import 'package:flutter/material.dart';

import '../util/utils/consts/text_style_constants.dart';
import '../util/utils/consts/ui_constants.dart';
import 'space_widget.dart';

class MoreWidget extends StatelessWidget {
  final String title;
  final String? img;
  final Function() onClick;

  const MoreWidget({
    super.key,
    required this.title,
    this.img,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClick,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Visibility(
                  visible: img != null,
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      color: UIConstants.gray7Color,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(img ?? ""),
                  ),
                ),
                Visibility(
                  visible: img != null,
                  child: const HorizontalSpace(16.0),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyleConstants.titleRegular.copyWith(
                      color: UIConstants.gray1Color,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/arrow_icon.png",
                  matchTextDirection: true,
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ),
        ),
        const Divider(height: 1.0),
      ],
    );
  }
}
