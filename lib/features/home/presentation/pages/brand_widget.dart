import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/rounded_clip_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';

import '../../../../data/home/HomeItemModel.dart';

class BrandWidget extends StatelessWidget {
  final HomeItemModel brandModel;
  final Function() onClick;

  final bool roundCorners;

  const BrandWidget({
    super.key,
    required this.brandModel,
    this.roundCorners = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 5 / 4,
          child: RoundedClipWidget(
            radius: roundCorners ? UIConstants.radius : 0,
            child: CachedImageWidget(imageUrl: brandModel.image ?? ""),
          ),
        ),
        const VerticalSpace(12.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            brandModel.title ?? "",
            textAlign: TextAlign.center,
            style: TextStyleConstants.headline6.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const VerticalSpace(8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            brandModel.subTitle ?? "",
            textAlign: TextAlign.center,
            style: TextStyleConstants.bodyRegular
                .copyWith(color: UIConstants.gray2Color),
          ),
        ),
        const VerticalSpace(16.0),
        OutlinedButtonWidget(
          width: MediaQuery.of(context).size.width * 0.55,
          borderColor: UIConstants.gray1Color,
          textColor: UIConstants.gray1Color,
          onClick: onClick,
          child: Text(brandModel.action?.text ?? ""),
        ),
        const VerticalSpace(30.0),
      ],
    );
  }
}
