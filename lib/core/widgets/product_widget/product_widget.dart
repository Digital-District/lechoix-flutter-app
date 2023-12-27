import 'package:flutter/material.dart';
import '../../base/base_state.dart';
import '../../util/utils/consts/text_style_constants.dart';
import '../../util/utils/consts/ui_constants.dart';
import '../image/cached_image_widget.dart';
import 'product_bloc.dart';
import '../space_widget.dart';
import '../../../data/model/ProductModel.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel product;
  final Function() onClick;
  final Function()? onFavorite;

  const ProductWidget({
    super.key,
    required this.product,
    required this.onClick,
    this.onFavorite,
  });

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends BaseState<ProductWidget, ProductBloc> {
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier<bool>(false);

  @override
  void initBloc() {
    bloc = ProductBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 2,
      child: GestureDetector(
        onTap: widget.onClick,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedImageWidget(
                    imageUrl: widget.product.image ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // IS NEW
                  Visibility(
                    visible: widget.product.isNew == true,
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              border: Border.all(
                                color: UIConstants.gray1Color,
                              ),
                            ),
                            child: Text(
                              localize("New"),
                              style: TextStyleConstants.overlineBold,
                            )),
                      ),
                    ),
                  ),
                  // EAVORITE
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _loadingNotifier,
                        builder: (context, value, child) {
                          return value
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : GestureDetector(
                                  onTap: onFavouriteClick,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Image.asset(
                                        widget.product.getFavoriteIcon),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VerticalSpace(12),
            Text(
              widget.product.brand?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleConstants.captionBold.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
            const VerticalSpace(8),
            Text(
              widget.product.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleConstants.bodyRegular.copyWith(
                color: UIConstants.gray1Color,
              ),
            ),
            const VerticalSpace(8),
            //NO Discount
            Visibility(
              visible: !widget.product.haseDiscount(),
              child: Text(
                "${widget.product.price ?? ""} ${widget.product.currency}",
                style: TextStyleConstants.price.copyWith(
                  color: UIConstants.goldColor,
                ),
              ),
            ),
            // Discount
            Visibility(
              visible: widget.product.haseDiscount(),
              child: Row(
                children: [
                  Text(
                    "${widget.product.price ?? ""} ${widget.product.currency}",
                    style: TextStyleConstants.price.copyWith(
                      color: UIConstants.gray2Color,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const HorizontalSpace(8),
                  Text(
                    "${widget.product.salePrice ?? ""} ${widget.product.currency}",
                    style: TextStyleConstants.price.copyWith(
                      color: UIConstants.redColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onFavouriteClick() async {
    _loadingNotifier.value = true;
    // await Future.delayed(Duration(milliseconds: 500));
    var res = await bloc.setFavorite(widget.product.id ?? 0);
    if (res != null) {
      widget.product.isFavorite = res.isFavorite;
    }
    widget.onFavorite?.call();
    _loadingNotifier.value = false;
  }
}
