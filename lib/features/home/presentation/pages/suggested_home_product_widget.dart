import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/product_widget/product_widget.dart';
import 'package:lechoix/core/widgets/scroll_indicator.dart';

import '../../../../../data/home/HomeItemModel.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/product/presentation/pages/product_screen.dart';

import 'package:lechoix/core/util/utils/navigation_util.dart';

import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

class SuggestedHomeProductWidget extends StatefulWidget {
  final HomeItemModel dataModel;
  final Function() onClick;

  const SuggestedHomeProductWidget(
      {super.key, required this.dataModel, required this.onClick});

  @override
  _SuggestedHomeProductWidgetState createState() =>
      _SuggestedHomeProductWidgetState();
}

class _SuggestedHomeProductWidgetState
    extends State<SuggestedHomeProductWidget> {
  ScrollController _brandController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            height: 1,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.dataModel.title ?? "",
              textAlign: TextAlign.center,
              style: TextStyleConstants.headline6.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        const VerticalSpace(10),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.dataModel.subTitle ?? "",
              textAlign: TextAlign.center,
              style: TextStyleConstants.bodyRegular.copyWith(
                color: UIConstants.gray2Color,
              ),
            ),
          ),
        ),
        const VerticalSpace(20),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.4 * 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _brandController,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: widget.dataModel.products?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProductWidget(
                  product: widget.dataModel.products![index],
                  onClick: () {
                    navigateToProduct(
                        context, widget.dataModel.products![index].id ?? 0);
                  },
                ),
              );
            },
          ),
        ),
        const VerticalSpace(20.0),
        ScrollIndicator(
          scrollController: _brandController,
          width: 100,
          height: 2,
          indicatorWidth: 20,
          decoration: const BoxDecoration(color: UIConstants.gray6Color),
          indicatorDecoration:
              const BoxDecoration(color: UIConstants.gray1Color),
        ),
        OutlinedButtonWidget(
          margin: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * 0.55,
          borderColor: UIConstants.gray1Color,
          textColor: UIConstants.gray1Color,
          onClick: widget.onClick,
          child: Text(widget.dataModel.action?.text ?? ""),
        ),
      ],
    );
  }

  void navigateToProduct(BuildContext context, int productId) {
    NavigationUtil.navigateTo(context, ProductScreen(productId: productId));
  }
}
