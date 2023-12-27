import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/card_widget.dart';
import 'package:lechoix/core/widgets/image/cached_image_widget.dart';
import 'package:lechoix/core/widgets/product_widget/product_widget.dart';
import 'package:lechoix/core/widgets/scroll_indicator.dart';
import 'package:lechoix/features/categories/presentation/pages/subcategory/sort_bottom_sheet/sort_bottom_sheet_widget.dart';
import 'package:lechoix/features/product/presentation/pages/size_guide_screen.dart';
import '../../../../core/base/base_state.dart';
import '../../../../core/base/dummy_bloc.dart';
import '../../../../data/model/ProductModel.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/features/product/presentation/pages/product_screen.dart';

import 'package:lechoix/core/util/utils/navigation_util.dart';

import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'gallery_view_screen.dart';

class ImagesSliderWidget extends StatefulWidget {
  final List<String> images;

  const ImagesSliderWidget(this.images, {super.key});

  @override
  State<ImagesSliderWidget> createState() => _ImagesSliderWidgetState();
}

class _ImagesSliderWidgetState
    extends BaseState<ImagesSliderWidget, DummyBloc> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: CarouselSlider(
            items: widget.images.map((e) {
              return GestureDetector(
                onTap: () {
                  openPhotos(widget.images,
                      initialIndex: widget.images.indexOf(e));
                },
                child: CachedImageWidget(
                  imageUrl: e,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1,
              height: MediaQuery.of(context).size.width,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          alignment: AlignmentDirectional.bottomCenter,
          child: AnimatedSmoothIndicator(
            activeIndex: _index,
            count: widget.images.length,
            effect: const WormEffect(
              activeDotColor: UIConstants.gray1Color,
              dotColor: UIConstants.gray5Color,
              spacing: 4.0,
              dotWidth: 8.0,
              dotHeight: 8.0,
            ),
          ),
        ),
      ],
    );
  }

  void openPhotos(List<String> images, {int initialIndex = 0}) {
    if (images.isNotEmpty) {
      navigateTo(GalleryViewScreen(images: images, initialIndex: initialIndex),
          fullscreenDialog: true);
    }
  }

  @override
  void initBloc() {
    bloc = DummyBloc(this);
    // TODO: implement initBloc
  }
}

class DropdownDisplayWidget<T> extends StatelessWidget {
  final T? selectedItem;
  final List<T> items;
  final String hint;
  final String title;
  final Function(T) onSelectItem;
  final bool showSizeWidget;
  final String? sizeGuideContent;

  const DropdownDisplayWidget({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.hint,
    required this.title,
    required this.onSelectItem,
    this.showSizeWidget = false,
    this.sizeGuideContent,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderColor: UIConstants.gray5Color,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (items.length > 1) {
            showSelectionBottomSheet<T>(
              context,
              title,
              items,
              (item) => onSelectItem(item),
              bottomWidget: showSizeWidget
                  ? NotSureSizeWidget(sizeGuideContent: sizeGuideContent ?? "")
                  : null,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedItem?.toString() ?? hint,
                  style: TextStyleConstants.bodyMedium.copyWith(
                    color: UIConstants.gray2Color,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}

class NotSureSizeWidget extends StatelessWidget {
  final String sizeGuideContent;

  const NotSureSizeWidget({super.key, required this.sizeGuideContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      color: UIConstants.gray6Color,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                NavigationUtil.navigateTo(
                    context, SizeGuideScreen(sizeGuideContent),
                    fullscreenDialog: true);
              },
              child: Text.rich(
                TextSpan(
                  style: TextStyleConstants.bodyRegular.copyWith(
                    color: UIConstants.gray1Color,
                  ),
                  children: [
                    TextSpan(text: "${tr("Not sure about your size?")} "),
                    TextSpan(
                      text: tr("View Full Size Guide"),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
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
    );
  }
}

class GetItTodayWidget extends StatelessWidget {
  final ProductModel? productModel;

  const GetItTodayWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      color: UIConstants.gray7Color,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset("assets/images/ic_delivery.png"),
          ),
          const HorizontalSpace(12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${tr("Sending one item from")} ${productModel?.brand?.country}, ${tr("delivered within")} ${productModel?.brand?.deliveryDurationDays} ${tr("days")}",
                  style: TextStyleConstants.captionMedium.copyWith(
                    color: UIConstants.gray2Color,
                  ),
                ),
              ],
            ),
          ),

          // Expanded(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Text(
          //         tr("Get it today"),
          //         style: TextStyleConstants.captionRegular.copyWith(
          //           color: UIConstants.gray1Color,
          //         ),
          //       ),
          //       VerticalSpace(4.0),
          //       Text(
          //         tr("Order in next 2 hours to get it delivered free!"),
          //         style: TextStyleConstants.captionMedium.copyWith(
          //           color: UIConstants.gray2Color,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ExpansionTileWidget extends StatelessWidget {
  final String title;
  final String body;

  const ExpansionTileWidget({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyleConstants.titleRegular.copyWith(
            color: UIConstants.gray1Color,
          ),
        ),
        iconColor: UIConstants.blackColor,
        collapsedIconColor: UIConstants.blackColor,
        children: [
          SizedBox(
            width: double.infinity,
            child: Html(data: body),
          ),
        ],
      ),
    );
  }
}

class SuggestedProductsWidget extends StatefulWidget {
  final String brandName;
  final List<ProductModel> brandProducts;
  final List<ProductModel> relatedProducts;
  final Function() onShowAllClick;

  const SuggestedProductsWidget({
    super.key,
    required this.brandName,
    required this.brandProducts,
    required this.relatedProducts,
    required this.onShowAllClick,
  });

  @override
  State<SuggestedProductsWidget> createState() =>
      _SuggestedProductsWidgetState();
}

class _SuggestedProductsWidgetState extends State<SuggestedProductsWidget> {
  ScrollController _brandController = ScrollController();
  ScrollController _relatedController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Text(
            "${tr("More from")} ${widget.brandName}",
            style: TextStyleConstants.titleRegular.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.4 * 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _brandController,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: widget.brandProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProductWidget(
                  product: widget.brandProducts[index],
                  onClick: () {
                    navigateToProduct(
                        context, widget.brandProducts[index].id ?? 0);
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
          child: Text(tr("SHOW ALL")),
          onClick: () {
            widget.onShowAllClick.call();
          },
        ),
        const Divider(height: 21.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Text(
            tr("You may also like"),
            style: TextStyleConstants.titleRegular.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.4 * 2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _relatedController,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: widget.relatedProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProductWidget(
                  product: widget.relatedProducts[index],
                  onClick: () {
                    navigateToProduct(
                        context, widget.relatedProducts[index].id ?? 0);
                  },
                ),
              );
            },
          ),
        ),
        const VerticalSpace(20.0),
        ScrollIndicator(
          scrollController: _relatedController,
          width: 100,
          height: 2,
          indicatorWidth: 20,
          decoration: const BoxDecoration(color: UIConstants.gray6Color),
          indicatorDecoration:
              const BoxDecoration(color: UIConstants.gray1Color),
        ),
      ],
    );
  }

  void navigateToProduct(BuildContext context, int productId) {
    NavigationUtil.navigateTo(context, ProductScreen(productId: productId));
  }
}
