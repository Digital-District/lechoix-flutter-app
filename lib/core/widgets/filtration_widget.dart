import 'package:flutter/material.dart';

import '../util/utils/consts/text_style_constants.dart';
import '../util/utils/consts/ui_constants.dart';
import 'image/cached_image_widget.dart';
import 'space_widget.dart';

class FiltrationWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final String img;
  final Function() onClick;
// "assets/images/logo_black_icon.png";

  const FiltrationWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onClick,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClick,
          behavior: HitTestBehavior.translucent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Visibility(
                  visible: img.isNotEmpty,
                  child: ClipOval(
                    child: CachedImageWidget(
                      imageUrl: img,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                Visibility(
                  visible: img.isNotEmpty,
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
                Visibility(
                  visible: isSelected,
                  child: const Icon(
                    Icons.check,
                    color: UIConstants.gray2Color,
                    size: 16.0,
                  ),
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
