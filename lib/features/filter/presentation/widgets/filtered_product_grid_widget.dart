import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/widgets/button/extended_label_with_icon_widget.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/product_widget/product_widget.dart';
import 'package:lechoix/core/widgets/product_widget/shimmer/product_grid_shimmer_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/paginated_grid_widget.dart';
import 'package:lechoix/features/categories/presentation/pages/subcategory/sort_bottom_sheet/sort_bottom_sheet_widget.dart';
import 'package:lechoix/features/categories/presentation/pages/subcategory/subcategories_bloc.dart';
import 'package:lechoix/features/filter/presentation/pages/main_filtration_screen.dart';
import 'package:lechoix/features/product/presentation/pages/product_screen.dart';
import '../../../../core/base/base_state.dart';

import '../../../../../data/filtration/FiltrationCriteriaModel.dart';
import '../../../../../data/model/ProductModel.dart';

class FilteredProductGridWidget extends StatefulWidget {
  static GlobalKey<_FilteredProductGridWidgetState> productsKeyState =
      GlobalKey();

  final Function(String)? onItemCountUpdated;
  final int categoryId;
  final int brandId;
  final Widget? topWidget;

  const FilteredProductGridWidget(
      {super.key,
      this.onItemCountUpdated,
      required this.categoryId,
      required this.brandId,
      this.topWidget});

  @override
  _FilteredProductGridWidgetState createState() =>
      _FilteredProductGridWidgetState();
}

class _FilteredProductGridWidgetState
    extends BaseState<FilteredProductGridWidget, SubcategoriesBloc> {
  FiltrationCriteriaModel filtrationModel = FiltrationCriteriaModel();
  String productsCount = "0";

  List<SortItemModel> sortedItems = [
    SortItemModel("best_sale", tr("Recommended")),
    SortItemModel("price_asc", tr("Price Low to High")),
    SortItemModel("price_desc", tr("Price High to Low")),
    SortItemModel("new", tr("New In")),
  ];

  late SortItemModel? selectedItem = sortedItems[0];

  @override
  void initBloc() {
    filtrationModel.categoryId = widget.categoryId;
    filtrationModel.brandId = widget.brandId;
    bloc = SubcategoriesBloc(this)
      ..setFiltrationModel(filtrationModel)
      ..getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedGridWidget<ProductModel>(
      stream: bloc.productsController.stream,
      onRetry: bloc.getProducts,
      onLoadMore: bloc.loadMore,
      padding: const EdgeInsets.all(16.0),
      loadingWidget: const ProductGridShimmerWidget(),
      topWidget: Column(
        children: [
          widget.topWidget ?? Container(),
          Row(
            children: [
              const HorizontalSpace(16.0),
              Expanded(
                child: OutlinedButtonWidget(
                  padding: const EdgeInsets.all(12.0),
                  fontSize: 12,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onClick: _gotoFiltrationScreen,
                  child: ExtendedLabelWithIconWidget(
                    icon: Image.asset(
                      "assets/images/ic_filter.png",
                      width: 16,
                      height: 16,
                    ),
                    label: tr("FILTERS"),
                  ),
                ),
              ),
              const HorizontalSpace(16.0),
              Expanded(
                child: OutlinedButtonWidget(
                  padding: const EdgeInsets.all(12.0),
                  fontSize: 12,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: ExtendedLabelWithIconWidget(
                    icon: Image.asset(
                      "assets/images/ic_sort.png",
                      width: 16,
                      height: 16,
                    ),
                    label: tr("SORT BY"),
                  ),
                  onClick: () {
                    showSelectionBottomSheet<SortItemModel>(
                        context, localize("SORT BY"), sortedItems, (item) {
                      if (item.id != filtrationModel.sortBy) {
                        selectedItem = item;
                        filtrationModel.sortBy = item.id;
                        _refreshData();
                      }
                    }, selectedItem: selectedItem);
                  },
                ),
              ),
              const HorizontalSpace(16.0),
            ],
          ),
          const VerticalSpace(16.0),
          const Divider(height: 1.0),
        ],
      ),
      onPaginationReceived: (paginationModel) {
        int total = paginationModel.total ?? 0;
        productsCount = total.toString();
        widget.onItemCountUpdated?.call(productsCount);
      },
      child: (productModel) {
        return ProductWidget(
          product: productModel,
          onClick: () {
            navigateTo(
              ProductScreen(productId: productModel.id ?? 0),
            );
            // myContext: NavigationUtil.categoriesNavigatorKey.currentContext,
          },
        );
      },
    );
  }

  _gotoFiltrationScreen() async {
    filtrationModel.productsCount = productsCount;

    final result = await navigateTo(
      MainFiltrationScreen(
        filtrationModel: filtrationModel,
      ),
      fullscreenDialog: true,
    );
    if (result != null) {
      filtrationModel = result;
      _refreshData();
    }
  }

  _refreshData() {
    bloc.clearAllData();
    bloc.setFiltrationModel(filtrationModel);
    bloc.getProducts(page: 1);
  }

  void search(String query) {
    filtrationModel.keyword = query;
    _refreshData();
  }
}
