import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/icon_button_widget.dart';
import 'package:lechoix/core/widgets/button/label_with_icon_widget.dart';
import 'package:lechoix/core/widgets/container_with_border_widget.dart';
import 'package:lechoix/core/widgets/loading_widget.dart';
import 'package:lechoix/core/widgets/need_help_widget.dart';
import 'package:lechoix/core/widgets/product_widget/product_bloc.dart';
import 'package:lechoix/data/cart/AddToCartRequestModel.dart';
import 'package:lechoix/features/cart/presentation/cubit/cart/cart_bloc.dart';
import '../../../../core/base/base_state.dart';
import '../../../../data/model/ColorModel.dart';
import '../../../../data/model/ProductModel.dart';
import '../../../../data/model/SizeModel.dart';
import '../../../../data/model/VariationModel.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/features/brandScreen/brand_screen.dart';

import 'package:lechoix/core/widgets/app_bar_widget.dart';

import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'helpers_widgets.dart';

class ProductScreen extends StatefulWidget {
  final int productId;

  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends BaseState<ProductScreen, ProductBloc> {
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier<bool>(false);

  ColorModel? _selectedColor;
  SizeModel? _selectedSize;
  VariationModel? _selectedVariation;
  late CartBloc cartBloc;

  @override
  void initBloc() {
    cartBloc = CartBloc(this);
    bloc = ProductBloc(this)
      ..setProductId(widget.productId)
      ..getProductDetails();
  }

  @override
  void dispose() {
    cartBloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamWidget<ProductModel?>(
      stream: bloc.productDetailsController.stream,
      onRetry: bloc.getProductDetails,
      loadingWidget: Scaffold(
        appBar: AppBarWidget(centerWidget: Container(), showDivider: false),
        body: const LoadingWidget(),
      ),
      child: (productModel) {
        _selectedColor ??= productModel?.colors?.firstOrNull;
        _selectedSize ??= productModel?.getFirstSizeValue(_selectedColor);

        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                elevation: 0,
                expandedHeight: MediaQuery.of(context).size.width,
                actions: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _loadingNotifier,
                    builder: (context, value, child) {
                      return value
                          ? Container(
                              margin: const EdgeInsets.all(16.0),
                              child: const AspectRatio(
                                aspectRatio: 1,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : IconButtonWidget(
                              icon: Icon(productModel?.getFavoriteIconData ??
                                  Icons.favorite_border),
                              onClick: () {
                                onFavouriteClick(productModel);
                              },
                            );
                    },
                  ),
                ],
                flexibleSpace: ImagesSliderWidget(
                    _selectedColor?.imagesOrNull ??
                        (productModel?.imageGallery ?? [])),
              ),
            ],
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        productModel?.brand?.name ?? "",
                                        style: TextStyleConstants.captionRegular
                                            .copyWith(
                                          color: UIConstants.gray2Color,
                                        ),
                                      ),
                                      const VerticalSpace(8.0),
                                      Text(
                                        productModel?.name ?? "",
                                        style: TextStyleConstants.bodyRegular
                                            .copyWith(
                                          color: UIConstants.gray1Color,
                                        ),
                                      ),
                                      const VerticalSpace(8.0),
                                      Text.rich(
                                        TextSpan(
                                          style: TextStyleConstants.bodyRegular,
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${getProductPrice(productModel)} ${productModel?.currency}",
                                              style: TextStyle(
                                                fontFamily: "Avenir",
                                                color: UIConstants.gray1Color,
                                                decoration: (getProductSalePrice(
                                                                productModel) !=
                                                            "0" &&
                                                        getProductSalePrice(
                                                                productModel) !=
                                                            "null")
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                              ),
                                            ),
                                            if (getProductSalePrice(
                                                        productModel) !=
                                                    "0" &&
                                                getProductSalePrice(
                                                        productModel) !=
                                                    "null")
                                              TextSpan(
                                                text:
                                                    " ${getProductSalePrice(productModel)} ${productModel?.currency}",
                                                // " ${productModel?.salePrice} ${productModel?.currency}",
                                                style: const TextStyle(
                                                    fontFamily: "Avenir",
                                                    color:
                                                        UIConstants.redColor),
                                              ),
                                            TextSpan(
                                              text: " ${tr("Including VAT")}",
                                              style: TextStyleConstants
                                                  .captionRegular
                                                  .copyWith(
                                                color: UIConstants.gray3Color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (productModel?.isOutOfStock == true)
                                  ContainerWithBorderWidget(
                                    borderColor: UIConstants.redColor,
                                    child: Text(
                                      tr("OUT OF STOCK"),
                                      style: TextStyleConstants.overlineRegular
                                          .copyWith(
                                        color: UIConstants.redColor,
                                        height: 1.2,
                                      ),
                                    ),
                                  )
                                else if (productModel?.isNew == true)
                                  ContainerWithBorderWidget(
                                    borderColor: UIConstants.gray1Color,
                                    child: Text(
                                      tr("NEW"),
                                      style: TextStyleConstants.overlineRegular
                                          .copyWith(
                                        color: UIConstants.gray2Color,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const VerticalSpace(16.0),
                            if (productModel?.isOutOfStock == true)
                              Text(
                                localize("This item is no longer available"),
                                style: TextStyleConstants.bodyRegular.copyWith(
                                  color: UIConstants.redColor,
                                ),
                              )
                            else
                              Row(
                                children: [
                                  Visibility(
                                    visible: productModel?.colors?.isNotEmpty ==
                                        true,
                                    child: Expanded(
                                      child: DropdownDisplayWidget<ColorModel>(
                                        hint: localize("Select color"),
                                        title: localize("SELECT COLOR"),
                                        selectedItem: _selectedColor,
                                        items: productModel?.colors ?? [],
                                        onSelectItem: (item) {
                                          _selectedColor = item;
                                          _selectedSize =
                                              productModel?.getFirstSizeValue(
                                                  _selectedColor);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: productModel?.colors?.isNotEmpty ==
                                            true &&
                                        (productModel?.haseSizes() ?? false),
                                    child: const HorizontalSpace(16.0),
                                  ),
                                  Visibility(
                                    visible:
                                        (productModel?.haseSizes() ?? false),
                                    child: Expanded(
                                      child: DropdownDisplayWidget<SizeModel>(
                                        hint: localize("Select size"),
                                        title: localize("SELECT YOUR SIZE"),
                                        selectedItem: _selectedSize,
                                        items: productModel?.getAvailableSizes(
                                                _selectedColor) ??
                                            [],
                                        showSizeWidget: true,
                                        sizeGuideContent:
                                            productModel?.sizeGuide,
                                        onSelectItem: (item) {
                                          setState(() {
                                            _selectedSize = item;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            Visibility(
                              visible: productModel?.isLimitedNumberRemaining ==
                                  true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const VerticalSpace(16.0),
                                  Text(
                                    localize(
                                        "${productModel?.stock ?? 0} ${localize("pieces left only")}"),
                                    style: TextStyleConstants.captionRegular
                                        .copyWith(
                                      color: UIConstants.redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: productModel?.isOutOfStock != true,
                        child: GetItTodayWidget(
                          productModel: productModel,
                        ),
                      ),
                      Visibility(
                        visible: productModel?.isOutOfStock == true,
                        child: SuggestedProductsWidget(
                          brandName: productModel?.brand?.name ?? "",
                          brandProducts: productModel?.brandProducts ?? [],
                          relatedProducts: productModel?.relatedProducts ?? [],
                          onShowAllClick: () {
                            if (bloc.productModel?.brand != null) {
                              navigateTo(BrandScreen(
                                  brandModel: bloc.productModel!.brand!));
                            }
                          },
                        ),
                      ),
                      Visibility(
                        visible: productModel?.isOutOfStock == true,
                        child: const Divider(height: 21.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ExpansionTileWidget(
                              title: localize("Product details"),
                              body: productModel?.description ?? "",
                            ),
                            const Divider(),
                            ExpansionTileWidget(
                              title: localize("Size & fit"),
                              body: productModel?.sizeFit ?? "",
                            ),
                            const Divider(),
                            ExpansionTileWidget(
                              title: localize("About the designer"),
                              body: productModel?.brand?.description ?? "",
                            ),
                            // Divider(),
                            // ExpansionTileWidget(
                            //   title: localize("Shipping & returns"),
                            //   body:
                            //       "${productModel?.brand?.deliveryDurationDays ?? ""} ${localize("days")}",
                            // ),
                          ],
                        ),
                      ),
                      const NeedHelpWidget(),
                      Visibility(
                        visible: productModel?.isOutOfStock != true,
                        child: SuggestedProductsWidget(
                          brandName:
                              "${localize("${productModel?.brand?.name ?? ""}")}",
                          brandProducts: productModel?.brandProducts ?? [],
                          relatedProducts: productModel?.relatedProducts ?? [],
                          onShowAllClick: () {
                            if (bloc.productModel?.brand != null) {
                              navigateTo(BrandScreen(
                                  brandModel: bloc.productModel!.brand!));
                            }
                          },
                        ),
                      ),
                      const VerticalSpace(88.0),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: ElevatedButtonWidget(
                    margin: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    onClick:
                        productModel?.isOutOfStock == true ? null : _addToCart,
                    child: LabelWithIconWidget(
                      label: localize("ADD TO BAG"),
                      icon: const Icon(Icons.shopping_bag_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onFavouriteClick(ProductModel? productModel) async {
    _loadingNotifier.value = true;
    var res = await bloc.setFavorite(productModel?.id ?? 0);
    if (res != null) {
      productModel?.isFavorite = res.isFavorite;
    }
    _loadingNotifier.value = false;
  }

  String getProductPrice(ProductModel? productModel) {
    if (_selectedColor != null || _selectedSize != null) {
      var _selectedVariation = productModel?.variations?.where((element) {
        return element.colorId == _selectedColor?.id &&
            element.sizeId == _selectedSize?.id;
      }).firstOrNull;
      if (_selectedVariation != null) return _selectedVariation.price ?? "0";
    }
    return productModel?.price ?? "0";
  }

  String getProductSalePrice(ProductModel? productModel) {
    if (_selectedColor != null || _selectedSize != null) {
      var _selectedVariation = productModel?.variations?.where((element) {
        return element.colorId == _selectedColor?.id &&
            element.sizeId == _selectedSize?.id;
      }).firstOrNull;
      if (_selectedVariation != null)
        return _selectedVariation.salePrice ?? "0";
    }
    return productModel?.salePrice ?? "0";
  }

  bool validateProductSalePrice(ProductModel? productModel) {
    if (_selectedColor != null || _selectedSize != null) {
      var _selectedVariation = productModel?.variations?.where((element) {
        return element.colorId == _selectedColor?.id &&
            element.sizeId == _selectedSize?.id;
      }).firstOrNull;
      if (_selectedVariation != null)
        return _selectedVariation.salePrice != null ? true : false;
    }
    return productModel?.salePrice != null ? true : false;
  }

  _addToCart() {
    AddToCartRequestModel model = AddToCartRequestModel(
        productId: widget.productId,
        sizeId: _selectedSize?.id,
        colorId: _selectedColor?.id);
    cartBloc.addToCart(model);
  }
}
