import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/show_less_more_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/filter/presentation/widgets/filtered_product_grid_widget.dart';

import '../../core/base/base_state.dart';
import '../../core/base/dummy_bloc.dart';
import '../../data/model/BrandModel.dart';

class BrandScreen extends StatefulWidget {
  final BrandModel brandModel;

  const BrandScreen({super.key, required this.brandModel});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends BaseState<BrandScreen, DummyBloc> {
  @override
  void initBloc() {
    bloc = DummyBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FilteredProductGridWidget(
        categoryId: -1,
        brandId: widget.brandModel.id ?? -1,
        topWidget: Column(
          children: [
            AppBar(
              elevation: 0,
              flexibleSpace: CachedImageWidget(
                imageUrl: widget.brandModel.image ?? "",
                fit: BoxFit.cover,
              ),
            ),
            const VerticalSpace(20),
            Text(
              widget.brandModel.name ?? "",
              style: TextStyleConstants.headline7
                  .copyWith(color: UIConstants.gray1Color),
            ),
            const VerticalSpace(8),
            ShowLessMoreWidget(
              fullText: widget.brandModel.description ?? "",
            ),
            const VerticalSpace(30),
          ],
        ),
      ),
    );
  }
}
